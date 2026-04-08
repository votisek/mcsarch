
gum style --bold "Setting up Prism Launcher..."

arch-chroot /mnt mkdir -p /etc/skel/.local/share/PrismLauncher
cp -r /root/mcsarch/prismlauncher/prismlauncher.cfg /mnt/etc/skel/.local/share/PrismLauncher/
mkdir -p /mnt/etc/skel/.local/share/PrismLauncher/instances
mkdir -p /mnt/etc/skel/.local/share/PrismLauncher/instances/MCSRRanked
unzip /root/mcsarch/prismlauncher/MCSRRanked.zip -d /mnt/etc/skel/.local/share/PrismLauncher/instances/ &> /dev/null

gum style --bold "Prism Launcher setup complete!"