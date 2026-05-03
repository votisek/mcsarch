# Core packages that every WM/DM option will have
mkdir -p /mnt/tmp/mcsarch_skel

chmod +x /root/mcsarch/sddm/install.sh
chmod +x /root/mcsarch/waywall/install.sh
chmod +x /root/mcsarch/prismlauncher/install.sh
chmod +x /root/mcsarch/grub/install.sh
chmod +x /root/mcsarch/kitty/install.sh
/root/mcsarch/sddm/install.sh
/root/mcsarch/waywall/install.sh
/root/mcsarch/prismlauncher/install.sh
/root/mcsarch/grub/install.sh
/root/mcsarch/kitty/install.sh
arch-chroot /mnt systemctl enable seatd
# Packages that everything except KDE will have
if [ "$1" != "Plasma" ]; then
  chmod +x /root/mcsarch/hyprlock/install.sh
  chmod +x /root/mcsarch/waybar/install.sh

  /root/mcsarch/hyprlock/install.sh
  /root/mcsarch/waybar/install.sh
fi

for user_dir in /mnt/home/*; do
  if [ -d "$user_dir" ]; then
    username=$(basename "$user_dir")
    if arch-chroot /mnt id "$username" >/dev/null 2>&1; then
      sudo cp -rf /mnt/tmp/mcsarch_skel/. "$user_dir/"
      arch-chroot /mnt chown -R "$username:$username" "/home/$username"
      arch-chroot /mnt usermod -aG seat,video,input "$username"
    fi
  fi
done

# Copy to etc/skel for future users
sudo cp -rf /mnt/tmp/mcsarch_skel/. /mnt/etc/skel/

# other misc scripts
rm /mnt/etc/os-release && cp /root/mcsarch/misc/os-release /mnt/etc/os-release # os release so fastfetch name is cool
chmod +x /root/mcsarch/scripts/*
cp /root/mcsarch/scripts/* /mnt/usr/local/bin/ # misc scripts for user
