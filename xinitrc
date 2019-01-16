#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Merge in defaults and keymaps
[ -f $sysresources ] && /usr/bin/xrdb -merge $sysresources
[ -f $sysmodmap ] && /usr/bin/xmodmap $sysmodmap
[ -f $userresources ] && /usr/bin/xrdb -merge $userresources
[ -f $usermodmap ] && /usr/bin/xmodmap $usermodmap

# adjust keyboard
xkbcomp -I$HOME/.config/xkb ~/.config/xkb/map $DISPLAY

# adjust screen size
# TODO it works with sleep, but I don't like this solution
# TODO move to a script
sleep 2
PRIMARY="eDP1"
xrandr --output $PRIMARY --mode 1920x1200 --primary --dpi 112
SECONDARY=`xrandr --query | grep -v "$PRIMARY" | grep " connected" | cut -d" " -f1`
if [ ! -z "$SECONDARY" ]
then
    xrandr --output $SECONDARY --mode 1920x1080 --above $PRIMARY --set "Broadcast RGB" "Full"
fi

# no DPMS
#xset s off -dpms

# custom key bindings
xbindkeys

# start i3
if [ -z "$DESKTOP_SESSION" -a -x /usr/bin/ck-launch-session ]; then
    exec ck-launch-session dbus-launch --exit-with-session /usr/bin/i3
else
    exec /usr/bin/i3
fi
