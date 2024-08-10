#!/bin/bash

echo "Updating system"
sudo pacman --noconfirm -Syu

# install base-devel if not installed
sudo pacman -S --noconfirm --needed base-devel wget git xorg-xrandr

mkdir -p ~/.config/dotfiles
git clone https://github.com/pbentes/dotfiles.git ~/.config/dotfiles

# install fonts
echo "Installing fonts"
mkdir -p ~/.local/share/fonts

cp -r ~/.config/dotfiles/fonts/* ~/.local/share/fonts/
fc-cache -f
clear

# install browser
sudo pacman -S --noconfirm firefox

# install file manager
sudo pacman -S --noconfirm thunar

# install neovim
sudo pacman -S --noconfirm neovim

# install nvm
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | sh

# install gimp
sudo pacman -S --noconfirm gimp

# install Yay
cd /opt
sudo git clone https://aur.archlinux.org/yay.git
sudo chown -R $(whoami):$(whoami) yay

cd yay
makepkg -si --noconfirm

cd ..
sudo rm -rf yay

# install picom
./pkg/yay/usr/bin/yay -S picom-ftlabs-git
sudo cp ~/.config/dotfiles/picom.conf ~/.config/picom.conf

# feh/wallpaper
sudo pacman -S --noconfirm feh
mkdir -p ~/Pictures/Wallpapers
sudo cp ~/.config/dotfiles/wallpapers/* ~/Pictures/Wallpapers

# install xinitrc
sudo cp ~/.config/dotfiles/.xinitrc ~/.xinitrc

startx