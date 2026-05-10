gum style --bold "Configuring waybar..."
arch-chroot /mnt mkdir -p /tmp/mcsarch_skel/.config/waybar
theme=$(gum choose --header "Please choose one of these color themes:" "Dracula" "Everforest")
cp -r /root/mcsarch/waybar/* /mnt/tmp/mcsarch_skel/.config/waybar/
rm -f /mnt/tmp/mcsarch_skel/.config/waybar/install.sh


sed -i "1i @import 'themes/$theme.css';" /mnt/tmp/mcsarch_skel/.config/waybar/style.css

gum style --bold "Done!"