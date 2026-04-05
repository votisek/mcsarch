USERNAME=$(arch-chroot /mnt awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | head -n1)

gum style --bold "Copying Jay config to new system..."
arch-chroot /mnt mkdir -p /home/$USERNAME/.config/jay
cp /root/mcsarch/Jay/config.toml /mnt/home/$USERNAME/.config/jay
mkdir -p /mnt/usr/share/wayland-sessions
cp /root/mcsarch/Jay/jay.desktop /mnt/usr/share/wayland-sessions/
gum style --bold "Done!"

/root/mcsarch/core.sh 