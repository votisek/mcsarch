USERNAME=$(arch-chroot /mnt awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd | head -n1)

gum style --bold "Configuring waywall..."
gum style --bold "Downloading Gore's Generic Config..."

if xrandr --listmonitors | grep "x1440" &> /dev/null; then
    git clone https://github.com/arjuncgore/waywall-generic-config.git -b 1440 /mnt/home/$USERNAME/mcsarch/.config/waywall >& /dev/null
else
    git clone https://github.com/arjuncgore/waywall-generic-config.git /mnt/home/$USERNAME/mcsarch/.config/waywall >& /dev/null
fi

gum style --bold "Done!"