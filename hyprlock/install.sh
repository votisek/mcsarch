USERNAME=$(arch-chroot /mnt awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | head -n1)

gum style --bold "Copying Hyprlock config to new system"
arch-chroot /mnt mkdir -p /home/$USERNAME/.config/hypr
cp /root/mcsarch/hyprlock/hyprlock.conf /mnt/home/$USERNAME/.config/hypr
gum style --bold "Done!"