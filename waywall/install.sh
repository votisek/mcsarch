
gum style --bold "Configuring waywall..."
gum style --bold "Downloading Gore's Generic Config..."

if [[ $(cat /sys/class/graphics/fb0/virtual_size) == "2560,1440" ]] && echo true || echo false &> /dev/null; then
    git clone https://github.com/arjuncgore/waywall-generic-config.git -b 1440 /mnt/etc/skel/mcsarch/.config/waywall >& /dev/null
else
    git clone https://github.com/arjuncgore/waywall-generic-config.git /mnt/etc/skel/mcsarch/.config/waywall >& /dev/null
fi

gum style --bold "Done!"