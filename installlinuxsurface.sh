#!/bin/bash

# Script to install Linux Surface support on Linux Mint
# https://github.com/linux-surface/linux-surface

set -e

# Import the keys
wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc \
    | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/linux-surface.gpg

echo "deb [arch=amd64] https://pkg.surfacelinux.com/debian release main" \
	| sudo tee /etc/apt/sources.list.d/linux-surface.list

# Update package list
sudo apt update

# Install Surface kernel and headers
sudo apt install linux-image-surface linux-headers-surface libwacom-surface iptsd

# Install the secureboot key
sudo apt install linux-surface-secureboot-mok

# Update GRUB
sudo update-grub

# Prompt for reboot
read -p $'\e[32mInstallation complete. Reboot now? [Y/n]: \e[0m' answer
if [[ $answer =~ ^[Yy]$ || -z $answer ]]; then
  sudo reboot now
else
  echo -e "\e[33mPlease reboot manually to use the Surface kernel.\e[0m"
fi
