USERNAME=$(arch-chroot /mnt awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | head -n1)

gum style --bold "Copying Kitty config to new system"
arch-chroot /mnt mkdir -p /home/$USERNAME/.config/kitty
cp /root/mcsarch/kitty/kitty.conf /mnt/home/$USERNAME/.config/kitty
gum style --bold "Done!"