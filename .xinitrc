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

([[ -f $HOME/.Xresources && -r ~/.Xresources ]] && xrdb -merge  $HOME/.Xresources) &

(anamnesis --start) &

xsetroot -cursor_name left_ptr &

xss-lock -- i3lock -n -i $HOME/Pictures/Underwater_Simple.png &

unclutter &

setxkbmap -option ctrl:nocaps &

(sleep 1s && mpd 2> /dev/null) &

exec herbstluftwm
