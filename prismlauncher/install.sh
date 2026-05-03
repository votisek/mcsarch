
gum style --bold "Setting up Prism Launcher..."

arch-chroot /mnt mkdir -p /tmp/mcsarch_skel/.local/share/PrismLauncher
cp -r /root/mcsarch/prismlauncher/prismlauncher.cfg /mnt/tmp/mcsarch_skel/.local/share/PrismLauncher/
mkdir -p /mnt/tmp/mcsarch_skel/.local/share/PrismLauncher/instances
unzip /root/mcsarch/prismlauncher/MCSRRanked.zip -d /mnt/tmp/mcsarch_skel/.local/share/PrismLauncher/instances/. &> /dev/null
mv /mnt/tmp/mcsarch_skel/.local/share/PrismLauncher/instances/

gum style --bold "Prism Launcher setup complete!"