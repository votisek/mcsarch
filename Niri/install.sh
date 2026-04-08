
gum style --bold "Copying Niri config to new system..."
arch-chroot /mnt mkdir -p /etc/skel/.config/niri
cp /root/mcsarch/Niri/config.kdl /mnt/etc/skel/.config/niri
gum style --bold "Done!"

/root/mcsarch/core.sh