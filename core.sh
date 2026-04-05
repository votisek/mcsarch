# Core packages that every WM/DM option will have
chmod +x /root/mcsarch/sddm/install.sh
chmod +x /root/mcsarch/waywall/install.sh
chmod +x /root/mcsarch/prismlauncher/install.sh
./root/mcsarch/sddm/install.sh
./root/mcsarch/waywall/install.sh
./root/mcsarch/prismlauncher/install.sh
arch-chroot /mnt usermod -aG seat,video,input $USERNAME
arch-chroot /mnt chown -R $USERNAME:$USERNAME /home/$USERNAME 
arch-chroot /mnt chown -R $USERNAME:$USERNAME /home/$USERNAME/.local
arch-chroot /mnt mkdir -p /home/$USERNAME/.config

# Packages that everything except KDE will have
if [ $1 != "Plasma" ]; then
    chmod +x /root/mcsarch/hyprlock/install.sh
    chmod +x /root/mcsarch/waybar/install.sh
    chmod +x /root/mcsarch/kitty/install.sh
    ./root/mcsarch/hyprlock/install.sh
    ./root/mcsarch/waybar/install.sh
    ./root/mcsarch/kitty/install.sh
fi
