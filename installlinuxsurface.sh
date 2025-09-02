#!/bin/bash
# Script to install Linux Surface support on Linux Mint
# https://github.com/linux-surface/linux-surface

set -e

# Add Linux Surface repository
sudo curl -fsSL https://linux-surface.github.io/linux-surface/linux-surface.key | gpg --dearmor -o /usr/share/keyrings/linux-surface.gpg

echo "deb [signed-by=/usr/share/keyrings/linux-surface.gpg] https://linux-surface.github.io/linux-surface/apt/ release main" > /etc/apt/sources.list.d/linux-surface.list

# Update package lists
sudo apt update

# Install Surface kernel and headers
sudo apt install -y linux-image-surface linux-headers-surface iptsd libwacom-surface

# Install surface-control (optional, for battery/keyboard/touchpad)
sudo apt install -y surface-control

# Update GRUB
sudo update-grub

# Prompt for reboot
read -p "Installation complete. Reboot now? [Y/n]: " answer
if [[ $answer =~ ^[Yy]$ || -z $answer ]]; then
  sudo reboot now
else
  echo "Please reboot manually to use the Surface kernel."
fi
