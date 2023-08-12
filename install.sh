#!/bin/bash

echo "Updating system"
sudo pacman --noconfirm -Syu

# install base-devel if not installed
sudo pacman -S --noconfirm --needed base-devel wget git

mkdir -p ~/.config/dotfiles
git clone https://github.com/pbentes/dotfiles.git ~/.config/dotfiles

# choose video driver
echo "1) xf86-video-intel 	2) xf86-video-amdgpu 3) nvidia 4) Skip"
read -r -p "Choose you video card driver(default 1)(will not re-install): " vid

case $vid in 
[1])
	DRI='xf86-video-intel'
	;;

[2])
	DRI='xf86-video-amdgpu'
	;;

[3])
	DRI='nvidia nvidia-settings nvidia-utils'
    	;;

[4])
	DRI=""
	;;
[*])
	DRI='xf86-video-intel'
	;;
esac

# install xorg if not installed
echo "Installing xorg"
sudo pacman -S --noconfirm --needed feh xorg xorg-xinit xorg-xinput $DRI

# install suckless utils
echo "Installing suckless programs"
cd ~/.config/dotfiles/suckless/st
sudo make clean install
make clean

cd ~/.config/dotfiles/suckless/dmenu
sudo make clean install
make clean

cd ~/.config/dotfiles/suckless/slstatus
sudo make clean install
make clean

cd ~/.config/dotfiles/suckless/dwm
sudo make clean install
make clean

cd ~
clear

# install fonts
echo "Installing fonts"
mkdir -p ~/.local/share/fonts

cp -r ~/.config/dotfiles/fonts/* ~/.local/share/fonts/
fc-cache -f
clear

# install AUR helper
mkdir -p ~/.srcs

HELPER="paru"
echo "We need an AUR helper. It is essential. 1) paru       2) yay"
read -r -p "What is the AUR helper of your choice? (Default is paru): " num

if [ $num -eq 2 ]
then
    HELPER="yay"
fi

if ! command -v $HELPER &> /dev/null
then
    echo "It seems that you don't have $HELPER installed, I'll install that for you before continuing."
	git clone https://aur.archlinux.org/$HELPER.git ~/.srcs/$HELPER
	(cd ~/.srcs/$HELPER/ && makepkg -si )
fi

$HELPER -S picom-ftlabs-git\
	   portmaster-stub-bin

# install wallpaper

# install picom.conf

# install browser

# install file manager

# install neovim

# install rust

# install nvm
