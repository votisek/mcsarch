
gum style --bold "Copying Hyprlock config to new system"
arch-chroot /mnt mkdir -p /etc/skel/.config/hypr
cp /root/mcsarch/hyprlock/hyprlock.conf /mnt/etc/skel/.config/hypr
gum style --bold "Done!"