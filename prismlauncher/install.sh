USERNAME=$(arch-chroot /mnt awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | head -n1)

gum style --bold "Setting up Prism Launcher..."

arch-chroot /mnt mkdir -p /home/$USERNAME/.local/share/PrismLauncher
cp -r /root/mcsarch/prismlauncher/prismlauncher.cfg /mnt/home/$USERNAME/.local/share/PrismLauncher/
mkdir -p /mnt/home/$USERNAME/.local/share/PrismLauncher/instances
mkdir -p /mnt/home/$USERNAME/.local/share/PrismLauncher/instances/MCSRRanked
unzip /root/mcsarch/prismlauncher/MCSRRanked.zip /mnt/home/$USERNAME/.local/share/PrismLauncher/instances/MCSRRanked

gum style --bold "Prism Launcher setup complete!"