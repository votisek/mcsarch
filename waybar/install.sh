USERNAME=$(arch-chroot /mnt awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | head -n1)

gum style --bold "Configuruing waybar..."
arch-chroot /mnt mkdir -p /home/$USERNAME/.config/
theme=$(gum choose --header "Please choose one of these color themes:" "Dracula" "Everforest")
cp /root/mcsarch/waybar/* /mnt/home/$USERNAME/.config/waybar -r

while true; do
    case theme in 
        "Dracula")
            sed -i "1i @import 'themes/dracula.css';" /mnt/home/$USERNAME/.config/waybar/style.css
            break
            ;;
        "Everforest")
            sed -i "1i @import 'themes/everforest.css';" /mnt/home/$USERNAME/.config/waybar/style.css
            break
            ;;
        *)
            gum style --bold "Wrong option. Please choose from the following."
    esac
done

gum style --bold "Done!"