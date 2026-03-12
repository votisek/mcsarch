echo "Installing jay..."

sudo pacman -S
echo "Jay installed!"
echo "Setting up configuration...


echo "Available themes:"
select theme in $(ls "$themes_dir" | grep ".css$"); do
    if [ -n "$theme" ]; then
        echo "Selected theme: $theme"
        echo "@import '$themes_dir/$theme';" > /usr/share/waybar/style.css
        break
    fi
done

