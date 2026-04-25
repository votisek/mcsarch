
gum style --bold "Setting up Prism Launcher..."

arch-chroot /mnt mkdir -p /etc/skel/.local/share/PrismLauncher
cp -r /root/mcsarch/prismlauncher/prismlauncher.cfg /mnt/etc/skel/.local/share/PrismLauncher/
mkdir -p /mnt/etc/skel/.local/share/PrismLauncher/instances
unzip /root/mcsarch/prismlauncher/MCSRRanked.zip -d /mnt/etc/skel/.local/share/PrismLauncher/instances/. &> /dev/null
mv /mnt/etc/skel/.local/share/PrismLauncher/instances/

gum style --bold "Prism Launcher setup complete!"