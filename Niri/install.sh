USERNAME=$(arch-chroot /mnt awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | head -n1)

gum style --bold "Copying Niri config to new system..."
arch-chroot /mnt mkdir -p /home/$USERNAME/.config/niri
cp /root/mcsarch/Niri/config.kdl /mnt/home/$USERNAME/.config/niri
gum style --bold "Done!"

/root/mcsarch/core.sh