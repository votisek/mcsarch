gum style --bold "Installing Jay..."
arch-chroot /mnt yay -S --no-confirm aur/jay-git

gum style --bold "Copying Jay config to new system..."
arch-chroot /mnt mkdir -p /tmp/mcsarch_skel/.config/jay
cp /root/mcsarch/Jay/config.toml /mnt/tmp/mcsarch_skel/.config/jay
mkdir -p /mnt/usr/share/wayland-sessions
cp /root/mcsarch/Jay/jay.desktop /mnt/usr/share/wayland-sessions/
gum style --bold "Done!"

/root/mcsarch/core.sh 