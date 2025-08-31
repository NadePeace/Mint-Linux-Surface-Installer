#!/bin/bash
# Script to install Linux Surface support on Linux Mint
# https://github.com/linux-surface/linux-surface

set -e

# Check for root
if [[ $EUID -ne 0 ]]; then
  echo "Please run as root (sudo $0)"
  exit 1
fi

# Add Linux Surface repository
curl -fsSL https://linux-surface.github.io/linux-surface/linux-surface.key | gpg --dearmor -o /usr/share/keyrings/linux-surface.gpg

echo "deb [signed-by=/usr/share/keyrings/linux-surface.gpg] https://linux-surface.github.io/linux-surface/apt/ release main" > /etc/apt/sources.list.d/linux-surface.list

# Update package lists
apt update

# Install Surface kernel and headers
apt install -y linux-image-surface linux-headers-surface iptsd libwacom-surface

# Install surface-control (optional, for battery/keyboard/touchpad)
apt install -y surface-control

# Update GRUB
update-grub

# Prompt for reboot
read -p "Installation complete. Reboot now? [Y/n]: " answer
if [[ $answer =~ ^[Yy]$ || -z $answer ]]; then
  reboot
else
  echo "Please reboot manually to use the Surface kernel."
fi
