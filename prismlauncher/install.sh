
gum style --bold "Setting up Prism Launcher..."

mkdir -p /mnt/tmp/mcsarch_skel/.local/share/PrismLauncher/instances
cp -r /root/mcsarch/prismlauncher/prismlauncher.cfg /mnt/tmp/mcsarch_skel/.local/share/PrismLauncher/
unzip -o /root/mcsarch/prismlauncher/MCSRRanked.zip -d /mnt/tmp/mcsarch_skel/.local/share/PrismLauncher/instances/ &> /dev/null

gum style --bold "Prism Launcher setup complete!"