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

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install AUR helper
mkdir -p ~/.srcs

HELPER="yay"
echo "We need an AUR helper. It is essential. 1) yay       2) pary"
read -r -p "What is the AUR helper of your choice? (Default is 1): " num

if [ $num -eq 2 ]
then
    HELPER="paru"
fi

if ! command -v $HELPER &> /dev/null
then
    echo "It seems that you don't have $HELPER installed, I'll install that for you before continuing."
	git clone https://aur.archlinux.org/$HELPER.git ~/.srcs/$HELPER
	cd ~/.srcs/$HELPER/ 
	makepkg -si
fi

# feh/wallpaper
sudo pacman -S --noconfirm feh
mkdir -p ~/Pictures/Wallpapers
cp ~/.config/dotfiles/wallpapers/* ~/Pictures/Wallpapers
feh --bg-fill ~/Pictures/Wallpapers/wallpaper.jpg
sudo chmod +x ~/.fehbg

# install browser

# install file manager

# install neovim
sudo pacman -S --noconfirm neovim

# install picom
$HELPER -S picom-ftlabs-git\
	   portmaster-stub-bin
cp ~/.config/dotfiles/picom.conf ~/.config/picom.conf

# install nvm
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | sh

# install gimp
sudo pacman -S --noconfirm gimp

# install xinitrc
cp ~/.config/dotfiles/.xinitrc ~/.xinitrc
