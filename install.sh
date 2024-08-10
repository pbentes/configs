#!/bin/bash

echo "Updating system"
sudo pacman --noconfirm -Syu

# install base-devel if not installed
sudo pacman -S --noconfirm --needed base-devel wget git

mkdir -p ~/.config/dotfiles
git clone https://github.com/pbentes/dotfiles.git ~/.config/dotfiles

# install fonts
echo "Installing fonts"
mkdir -p ~/.local/share/fonts

cp -r ~/.config/dotfiles/fonts/* ~/.local/share/fonts/
fc-cache -f
clear

# install suckless utils
echo "Installing suckless programs"

cd ~/.config/dotfiles/suckless/st
sudo make clean install
make clean
clear

cd ~/.config/dotfiles/suckless/dmenu
sudo make clean install
make clean
clear

cd ~/.config/dotfiles/suckless/slstatus
sudo make clean install
make clean
clear

cd ~/.config/dotfiles/suckless/dwm
sudo make clean install
make clean
cd ~
clear

# install xinitrc
sudo cp ~/.config/dotfiles/.xinitrc ~/.xinitrc

# feh/wallpaper
sudo pacman -S --noconfirm feh
mkdir -p ~/Pictures/Wallpapers
sudo cp ~/.config/dotfiles/wallpapers/* ~/Pictures/Wallpapers
feh --bg-fill ~/Pictures/Wallpapers/wallpaper.jpg
sudo chmod +x ~/.fehbg

# install browser
sudo pacman -S --noconfirm firefox

# install file manager


# install neovim
sudo pacman -S --noconfirm neovim

# install nvm
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | sh

# install gimp
sudo pacman -S --noconfirm gimp

# install Yay
mkdir -p ~/.srcs

git clone https://aur.archlinux.org/yay.git ~/.srcs/yay
cd ~/.srcs/yay/ 
makepkg -si

# install picom
yay -S picom-ftlabs-git
sudo cp ~/.config/dotfiles/picom.conf ~/.config/picom.conf

