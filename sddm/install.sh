gum style --bold "Installing SDDM..."
gum style --bold "You can preview these themes in the repo."
theme="$(gum choose --header "Please choose one of these, you can always choose another one." "Jake the dog" "Minecraft" "Minimal" "Sakura" "Japanese Aesthetic")"
mkdir -p /mnt/usr/share/sddm/themes
mkdir -p /mnt/usr/share/fonts
mkdir -p /mnt/etc/sddm.conf.d
cp -r /root/mcsarch/sddm/themes/* /mnt/usr/share/sddm/themes/
cp -r /root/mcsarch/sddm/fonts/* /mnt/usr/share/fonts/

case "$theme" in
    "Jake the dog")
        theme_name="jake-the-dog"
        ;;
    "Minecraft")
        theme_name="minecraft"
        ;;
    "Minimal")
        theme_name="minimal"
        ;;
    "Sakura")
        theme_name="sakura"
        ;;
    "Japanese Aesthetic")
        theme_name="japanese-aesthetic"
        ;;
    *)
        gum style --bold "Wrong option. Please choose from the following."
        exit 1
        ;;
esac

printf "[Theme]\nCurrent=%s\n" "$theme_name" > /mnt/etc/sddm.conf.d/theme.conf

systemctl --root=/mnt enable sddm

gum style --bold "Done!"