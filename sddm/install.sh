USERNAME=$(arch-chroot /mnt awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | head -n1)

gum style --bold "Installing SDDM..."
gum style --bold "You can preview these themes in the repo."
theme="$(gum choose --header "Please choose one of these, you can always choose another one." "Jake the dog" "Minecraft" "Minimal" "Sakura" "Japanese Aesthetic")"
mkdir -p /mnt/usr/share/sddm/themes
mkdir -p /mnt/etc/sddm.conf.d
cp /root/mcsarch/sddm/themes/* /mnt/usr/share/sddm/themes -r

while true; do
    case theme in 
        "Jake the dog")
            echo "[Theme]\ntheme='jake-the-dog'" > /mnt/etc/sddm.conf.d/theme.conf
            break
            ;;
        "Minecraft")
            echo "[Theme]\ntheme='minecraft'" > /mnt/etc/sddm.conf.d/theme.conf
            break
            ;;
        "Minimal")
            echo "[Theme]\ntheme='minimal'" > /mnt/etc/sddm.conf.d/theme.conf
            break
            ;;
        "Sakura")
            echo "[Theme]\ntheme='sakura'" > /mnt/etc/sddm.conf.d/theme.conf
            break
            ;;
        "Japanese Aesthetic")
            echo "[Theme]\ntheme='japanese-aesthetic'" > /mnt/etc/sddm.conf.d/theme.conf
            break
            ;;
        *)
            gum style --bold "Wrong option. Please choose from the following."
    esac
done

systemctl --root=/mnt enable sddm

gum style --bold "Done!"