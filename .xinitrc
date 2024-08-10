#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

monitors=$(xrandr --query | grep " connected" | cut -d ' ' -f1)
for monitor in $monitors; do
    # Get the native resolution and refresh rate for each monitor
    native_mode=$(xrandr --query | grep -A1 "^$monitor connected" | tail -n1 | awk '{print $1}')
    native_refresh_rate=$(xrandr --query | grep -A1 "^$monitor connected" | tail -n1 | awk '{print $NF}')
    
    # Set the monitor to its native resolution and refresh rate
    echo "Setting $monitor to $native_mode at $native_refresh_rate Hz"
    xrandr --output $monitor --mode $native_mode --rate $native_refresh_rate
done

cd ~/.config/dotfiles/suckless/st
sudo make clean install

cd ~/.config/dotfiles/suckless/dmenu
sudo make clean install

cd ~/.config/dotfiles/suckless/slstatus
sudo make clean install

cd ~/.config/dotfiles/suckless/dwm
sudo make clean install
cd ~

if [ ! -f "~/.fehbg" ]; then
    feh --bg-fill ~/Pictures/Wallpapers/wallpaper.jpg
    sudo chmod +x ~/.fehbg
else 
    sh ~/.fehbg
fi

picom -b --animations --config ~/.config/picom.conf &
slstatus &
dwm
