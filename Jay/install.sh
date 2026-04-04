USERNAME=$(arch-chroot /mnt awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | head -n1)

arch-chroot /mnt usermod -aG seat,video,input $USERNAME
arch-chroot /mnt mkdir -p /home/$USERNAME/.config
arch-chroot /mnt chown -R $USERNAME:$USERNAME /home/$USERNAME 

gum style --bold "Copying Jay config to new system..."
arch-chroot /mnt mkdir -p /home/$USERNAME/.config/jay
cp /root/mcsarch/Jay/config.toml /mnt/home/$USERNAME/.config/jay
gum style --bold "Done!"

chmod +x /root/mcsarch/sddm/install.sh
chmod +x /root/mcsarch/hyprlock/install.sh
chmod +x /root/mcsarch/waybar/install.sh
chmod +x /root/mcsarch/kitty/install.sh
/root/mcsarch/hyprlock/install.sh
/root/mcsarch/waybar/install.sh
/root/mcsarch/sddm/install.sh
/root/mcsarch/kitty/install.sh