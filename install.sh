#!/bin/bash

su

echo "Updating system"
sudo pacman --noconfirm -Syu

# install base-devel if not installed
sudo pacman -S --noconfirm --needed base-devel wget git xorg-xrandr

mkdir ~/Desktop
mkdir ~/Pictures
mkdir ~/Documents

mkdir -p ~/.config/dotfiles
git clone https://github.com/pbentes/dotfiles.git ~/.config/dotfiles

# install fonts
echo "Installing fonts"
mkdir -p ~/.local/share/fonts

cp -r ~/.config/dotfiles/fonts/* ~/.local/share/fonts/
fc-cache -f
clear

# install tor
sudo pacman -S --noconfirm tor

sudo cp /etc/tor/torrc /etc/tor/torrc.bak

cat <<EOL >> /etc/tor/torrc
VirtualAddrNetworkIPv4 10.192.0.0/10
AutomapHostsOnResolve 1
TransPort 9040
DNSPort 5353
EOL

# install file manager
sudo pacman -S --noconfirm nautilus

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

# install browser
yay -S --noconfirm brave-bin

# install picom
yay -S --noconfirm picom-ftlabs-git

# install onlyoffice
yay -S --noconfirm onlyoffice-bin

# feh/wallpaper
sudo pacman -S --noconfirm feh
mkdir -p ~/Pictures/Wallpapers
sudo cp ~/.config/dotfiles/wallpapers/* ~/Pictures/Wallpapers

# install xinitrc
sudo cp ~/.config/dotfiles/.xinitrc ~/.xinitrc
sudo chmod +x ~/.xinitrc

install_suckless() {
    local command=$1
    local dir=$2

    cd "$dir" || exit
    sudo make clean install
}

install_suckless "dmenu" "$HOME/.config/dotfiles/suckless/st"
install_suckless "dmenu" "$HOME/.config/dotfiles/suckless/dmenu"
install_suckless "slstatus" "$HOME/.config/dotfiles/suckless/slstatus"
install_suckless "dwm" "$HOME/.config/dotfiles/suckless/dwm"

# install ly
sudo pacman -S --noconfirm ly

# setup iptables
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t nat -A OUTPUT -m owner --uid-owner tor -j RETURN
sudo iptables -t nat -A OUTPUT -p tcp --dport 9040 -j RETURN
sudo iptables -t nat -A OUTPUT -d 127.0.0.1/8 -j RETURN
sudo iptables -t nat -A OUTPUT -p tcp -j REDIRECT --to-ports 9040
sudo iptables -t nat -A OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 5353

sudo iptables-save > /etc/iptables/iptables.rules

# start services
sudo systemctl enable tor
sudo systemctl start tor

sudo systemctl enable iptables
sudo systemctl enable iptables

sudo systemctl enable ly.service
sudo systemctl start ly.service

sudo reboot