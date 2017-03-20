#!/bin/sh
#
# ~/.xinitrc
#
# Executed upon `startx`

# Run any system-wide scripts
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# Our custom resources for various X clients (e.g. urxvt)
user_resources=$HOME/.Xresources
[ -f "$user_resources" ] && xrdb -merge "$user_resources"

# We shall have a cursor from the get-go
xsetroot -cursor_name left_ptr

# Script to first detect and orient multihead setup
/usr/local/bin/monitor.sh

# Multihead wallpaper
feh --no-fehbg --bg-scale ~/media/images/wallpaper-1.jpg ~/media/images/wallpaper-1.jpg

# Tear free beauty
compton -CGb --no-fading-openclose

# Ultra-fast terminal startup
urxvtd -q -f -o

# Disable DPMS and prevent screen from blanking
xset s off -dpms

# Swanky, tiling window manager
exec xmonad
