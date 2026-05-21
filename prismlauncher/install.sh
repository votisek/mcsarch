
gum style --bold "Setting up Prism Launcher..."

mkdir -p /mnt/tmp/mcsarch_skel/.local/share/PrismLauncher/instances
cp -r /root/mcsarch/prismlauncher/prismlauncher.cfg /mnt/tmp/mcsarch_skel/.local/share/PrismLauncher/
tar -xf /root/mcsarch/prismlauncher/mcsrranked.tar.zst -C /mnt/tmp/mcsarch_skel/.local/share/PrismLauncher/instances/MCSRRanked &> /dev/null

gum style --bold "Prism Launcher setup complete!"