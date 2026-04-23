gum style --bold "Installing Jay..."
arch-chroot /mnt git clone https://aur.archlinux.org/jay-git.git /opt/jay
arch-chroot /mnt cd /opt/jay/
arch-chroot /mnt makepkg -si --noconfirm
arch-chroot /mnt pacman -U *.tar.zst --noconfirm
echo EOF<<
ps=$(pwd)
cd /opt/jay/
makepkg -si --noconfirm
pacman -U *.tar.zst --noconfirm
cd $ps
EOF

gum style --bold "Copying Jay config to new system..."
arch-chroot /mnt mkdir -p /etc/skel/.config/jay
cp /root/mcsarch/Jay/config.toml /mnt/etc/skel/.config/jay
mkdir -p /mnt/usr/share/wayland-sessions
cp /root/mcsarch/Jay/jay.desktop /mnt/usr/share/wayland-sessions/
gum style --bold "Done!"

/root/mcsarch/core.sh 