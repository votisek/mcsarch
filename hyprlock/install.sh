
gum style --bold "Copying Hyprlock config to new system"
arch-chroot /mnt mkdir -p /tmp/mcsarch_skel/.config/hypr
cp /root/mcsarch/hyprlock/hyprlock.conf /mnt/tmp/mcsarch_skel/.config/hypr
cp /root/mcsarch/hyprlock/fonts/* /mnt/usr/share/fonts
gum style --bold "Done!"