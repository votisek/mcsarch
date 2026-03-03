echo "Installing login screen theme..."
echo "Look at the examples at the github repository at https://github.com/votisek/mcsarch"

curl -L https://raw.githubusercontent.com/votisek/mcsarch/config/sddm/sddm.tar.zst -O /tmp/sddm.tar.zst

mkdir -p /tmp/sddm
mkdir -p /usr/share/sddm
tar -xfv /tmp/sddm.tar.zst /tmp/sddm

cp /tmp/sddm/themes/ /usr/share/sddm/ -r
cp /tmp/sddm/fonts/* /usr/share/fonts/ -r

theme=gum choose 'minimal' 'minecraft' 'sakura' 'jake-the-dog' 'japanese-aesthetic'

echo "[Theme]\nCurrent=$theme" > /etc/sddm.conf.d/theme.conf
echo "Theme applied!"
echo "All themes were taken from the authors mentioned in the metadata.desktop in each theme folder. Make sure to check them all!"#!/usr/bin/zsh
