#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xsetroot -cursor_name left_ptr

xset +fp /usr/share/fonts/local
xset fp rehash

# activate numlock
numlockx &

feh --bg-scale ~/media/images/wallpapers/Eos_left.bmp ~/media/images/wallpapers/Eos_right.bmp

exec xmonad
# exec openbox-session
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
