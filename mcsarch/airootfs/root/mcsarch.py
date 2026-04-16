import os
import sys
import time

from archinstall.lib.applications.application_handler import ApplicationHandler
from archinstall.lib.args import ArchConfig, ArchConfigHandler
from archinstall.lib.authentication.authentication_handler import AuthenticationHandler
from archinstall.lib.configuration import ConfigurationOutput
from archinstall.lib.disk.filesystem import FilesystemHandler
from archinstall.lib.disk.utils import disk_layouts
from archinstall.lib.general.general_menu import PostInstallationAction, select_post_installation
from archinstall.lib.global_menu import GlobalMenu
from archinstall.lib.installer import Installer, accessibility_tools_in_use, run_custom_user_commands
from archinstall.lib.menu.util import delayed_warning
from archinstall.lib.mirror.mirror_handler import MirrorListHandler
from archinstall.lib.models import Bootloader
from archinstall.lib.models.device import DiskLayoutType, EncryptionType
from archinstall.lib.models.users import User
from archinstall.lib.network.network_handler import install_network_config
from archinstall.lib.output import debug, error, info
from archinstall.lib.packages.util import check_version_upgrade
from archinstall.lib.profile.profiles_handler import profile_handler
from archinstall.lib.translationhandler import tr
from archinstall.tui.ui.components import tui

from archinstall.lib.disk.disk_menu import select_devices, suggest_single_disk_layout
from archinstall.lib.models.device import DiskLayoutConfiguration, DiskLayoutType
from archinstall.lib.models.authentication import AuthenticationConfiguration
from archinstall.lib.authentication.authentication_menu import select_root_password, select_users

async def fast_disk_picker(preset=None):
	devices = await select_devices()
	if not devices:
		return preset
	
	device = devices[0]
	modification = await suggest_single_disk_layout(device)
	if modification:
		return DiskLayoutConfiguration(
			config_type=DiskLayoutType.Default,
			device_modifications=[modification]
		)
	return preset

async def fast_auth_picker(preset=None):
	user = await select_users("Select a user to create")
	if not user:
		return preset
	return AuthenticationConfiguration(user[0].password, user)
	


def show_menu(
	arch_config_handler: ArchConfigHandler,
	mirror_list_handler: MirrorListHandler,
) -> None:
	upgrade = check_version_upgrade()
	title_text = 'MCSaRch'

	if upgrade:
		text = tr('New version available') + f': {upgrade}'
		title_text += f' ({text})'

	global_menu = GlobalMenu(
		arch_config_handler.config,
		mirror_list_handler,
		arch_config_handler.args.skip_boot,
		advanced=arch_config_handler.args.advanced,
		title=title_text,
	)
	items = [
		'disk_config',
		'auth_config',
		'__config___save',
		'__config___install', 
		'__config___abort'
	]
	
	for item in global_menu._item_group.items:
		if item.key == 'disk_config':
			item.action = fast_disk_picker
			item.text = "Disk Configuration"
		if item.key == 'auth_config':
			item.action = fast_auth_picker
			item.text = "Authentication"
	
	global_menu._item_group.items = [
        item for item in global_menu._item_group.items 
        if item.key in items or item.key is None
    ]

	result: ArchConfig | None = tui.run(global_menu)

def perform_installation(
	arch_config_handler: ArchConfigHandler,
	mirror_list_handler: MirrorListHandler,
	auth_handler: AuthenticationHandler,
	application_handler: ApplicationHandler,
) -> None:
	"""
	Performs the installation steps on a block device.
	Only requirement is that the block devices are
	formatted and setup prior to entering this function.
	"""
	start_time = time.monotonic()
	info('Starting installation...')

	mountpoint = arch_config_handler.args.mountpoint
	config = arch_config_handler.config

	if not config.disk_config:
		error('No disk configuration provided')
		return

	disk_config = config.disk_config
	run_mkinitcpio = not config.bootloader_config or not config.bootloader_config.uki
	locale_config = config.locale_config
	optional_repositories = config.mirror_config.optional_repositories if config.mirror_config else []
	mountpoint = disk_config.mountpoint if disk_config.mountpoint else mountpoint

	with Installer(
		mountpoint,
		disk_config,
		kernels=config.kernels,
		silent=arch_config_handler.args.silent,
	) as installation:
		# Mount all the drives to the desired mountpoint
		if disk_config.config_type != DiskLayoutType.Pre_mount:
			installation.mount_ordered_layout()

		installation.sanity_check(
			arch_config_handler.args.offline,
			arch_config_handler.args.skip_ntp,
			arch_config_handler.args.skip_wkd,
		)

		if disk_config.config_type != DiskLayoutType.Pre_mount:
			if disk_config.disk_encryption and disk_config.disk_encryption.encryption_type != EncryptionType.NoEncryption:
				# generate encryption key files for the mounted luks devices
				installation.generate_key_files()

		if mirror_config := config.mirror_config:
			installation.set_mirrors(mirror_list_handler, mirror_config, on_target=False)

		installation.minimal_installation(
			optional_repositories=optional_repositories,
			mkinitcpio=run_mkinitcpio,
			hostname=arch_config_handler.config.hostname,
			locale_config=locale_config,
			pacman_config=config.pacman_config,
		)

		if mirror_config := config.mirror_config:
			installation.set_mirrors(mirror_list_handler, mirror_config, on_target=True)

		if config.swap and config.swap.enabled:
			installation.setup_swap(algo=config.swap.algorithm)

		if config.bootloader_config and config.bootloader_config.bootloader != Bootloader.NO_BOOTLOADER:
			installation.add_bootloader(config.bootloader_config.bootloader, config.bootloader_config.uki, config.bootloader_config.removable)

		if config.network_config:
			install_network_config(
				config.network_config,
				installation,
				config.profile_config,
			)

		users = None
		if config.auth_config:
			if config.auth_config.users:
				users = config.auth_config.users
				installation.create_users(config.auth_config.users)
				auth_handler.setup_auth(installation, config.auth_config, config.hostname)

		if app_config := config.app_config:
			application_handler.install_applications(installation, app_config)

		if profile_config := config.profile_config:
			profile_handler.install_profile_config(installation, profile_config)

		if config.packages and config.packages[0] != '':
			installation.add_additional_packages(config.packages)

		if timezone := config.timezone:
			installation.set_timezone(timezone)

		if config.ntp:
			installation.activate_time_synchronization()

		if accessibility_tools_in_use():
			installation.enable_espeakup()

		if config.auth_config and config.auth_config.root_enc_password:
			root_user = User('root', config.auth_config.root_enc_password, False)
			installation.set_user_password(root_user)

		if (profile_config := config.profile_config) and profile_config.profile:
			profile_config.profile.post_install(installation)

			if users:
				profile_config.profile.provision(installation, users)

		# If the user provided a list of services to be enabled, pass the list to the enable_service function.
		# Note that while it's called enable_service, it can actually take a list of services and iterate it.
		if services := config.services:
			installation.enable_service(services)

		if disk_config.has_default_btrfs_vols():
			btrfs_options = disk_config.btrfs_options
			snapshot_config = btrfs_options.snapshot_config if btrfs_options else None
			snapshot_type = snapshot_config.snapshot_type if snapshot_config else None
			if snapshot_type:
				bootloader = config.bootloader_config.bootloader if config.bootloader_config else None
				installation.setup_btrfs_snapshot(snapshot_type, bootloader)

		# If the user provided custom commands to be run post-installation, execute them now.
		if cc := config.custom_commands:
			run_custom_user_commands(cc, installation)

		installation.genfstab()

		debug(f'Disk states after installing:\n{disk_layouts()}')


def main(arch_config_handler: ArchConfigHandler | None = None) -> None:
	if arch_config_handler is None:
		arch_config_handler = ArchConfigHandler()

	mirror_list_handler = MirrorListHandler(
		offline=arch_config_handler.args.offline,
		verbose=arch_config_handler.args.verbose,
	)

	if not arch_config_handler.args.silent:
		show_menu(arch_config_handler, mirror_list_handler)

	config = ConfigurationOutput(arch_config_handler.config)
	config.write_debug()
	config.save()

	if arch_config_handler.args.dry_run:
		return

	if not arch_config_handler.args.silent:
		aborted = False
		res: bool = tui.run(config.confirm_config)

		if not res:
			debug('Installation aborted')
			aborted = True

		if aborted:
			return main(arch_config_handler)

	if arch_config_handler.config.disk_config:
		fs_handler = FilesystemHandler(arch_config_handler.config.disk_config)

		if not delayed_warning(tr('Starting device modifications in ')):
			return main()

		fs_handler.perform_filesystem_operations()

	perform_installation(
		arch_config_handler,
		mirror_list_handler,
		AuthenticationHandler(),
		ApplicationHandler(),
	)


if __name__ == '__main__':
	main()
