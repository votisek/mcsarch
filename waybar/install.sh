gum style --bold "Configuring waybar..."
arch-chroot /mnt mkdir -p /etc/skel/.config/waybar
theme=$(gum choose --header "Please choose one of these color themes:" "Dracula" "Everforest")
cp /root/mcsarch/waybar/* /mnt/etc/skel/.config/waybar -r


sed -i "1i @import 'themes/$theme.css';" /mnt/etc/skel/.config/waybar/style.css

gum style --bold "Done!"