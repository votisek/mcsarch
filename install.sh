#!/bin/bash

curl -sL https://repo.vojta.fyi/votisek.pub > /tmp/votisek.pub
sudo pacman-key --add /tmp/votisek.pub
sudo pacman-key --lsign-key "votisek@proton.me"
rm /tmp/votisek.pub

if grep -q "^\[mcsarch\]" /etc/pacman.conf; then
    echo "Repo already exists"
else
    sudo bash -c 'cat >> /etc/pacman.conf <<EOF

[mcsarch]
Server = https://repo.vojta.fyi/\$arch
EOF'
fi

echo "Updating package database..."
sudo pacman -Sy

echo "Done!"
