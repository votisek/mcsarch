
gum style --bold "Copying Kitty config to new system"
arch-chroot /mnt pacman -S --noconfirm --needed ttf-firacode-nerd > /dev/null
arch-chroot /mnt mkdir -p /tmp/mcsarch_skel/.config/kitty
cp /root/mcsarch/kitty/kitty.conf /mnt/tmp/mcsarch_skel/.config/kitty
gum style --bold "Done!"