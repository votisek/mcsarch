gum style --bold "Installing GRUB theme"
cp -r /root/mcsarch/grub/minegrub /mnt/boot/grub/themes/
echo "GRUB_THEME=/boot/grub/themes/minegrub/theme.txt" >> /mnt/etc/default/grub
gum style --bold "Generating GRUB configuration"
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
gum style --bold "GRUB installation complete"