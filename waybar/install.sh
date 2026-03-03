echo "Installing waybar themes..."

echo "Look at the examples at the github repository at https://github.com/votisek/mcsarch"

themes_dir="/usr/share/waybar/themes"
fonts_dir="/usr/share/fonts"

mkdir -p "$themes_dir"
mkdir -p "$fonts_dir"

cp -r "$(dirname "$0")/themes/"* "$themes_dir/"

echo "Available themes:"
select theme in $(ls "$themes_dir" | grep ".css$"); do
    if [ -n "$theme" ]; then
        echo "Selected theme: $theme"
        echo "@import '$themes_dir/$theme';" > /usr/share/waybar/style.css
        break
    fi
done

echo "Theme applied!"
echo "All themes were taken from the authors mentioned in the theme files. Make sure to check them all!"
