#!/bin/env bash

# sets wallpaper using feh
# bash $HOME/.dwm/.fehbg

# kill if already running
killall -9 picom xfce4-power-manager dunst sxhkd nm-applet blueman-applet optimus-manager-qt

# Launch Conkeww
# sed -i "s/colors\/color-.*/colors\/color-one-dark.yuck\")/g" $HOME/.config/conkeww/eww.yuck
# eww --config $HOME/.config/conkeww/ open conkeww-main

# sets superkey
#ksuperkey -e 'Super_L=Alt_L|F1' &
#ksuperkey -e 'Super_R=Alt_L|F1' &

# starts dwmblocks
# dwmblocks &

# start hotkey daemon
sxhkd &

# unclutter
unclutter &

# start bluetooth
blueman-applet &

# Launch notification daemon
# dunst -config $HOME/.config/dunst/dunstrc &

# start compositor and power manager
xfce4-power-manager &

# display timeout settings
xset s 480 dpms 600 600 600

feh --bg-fill /home/eli/.config/wallpaper.jpg

while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom &

# start polkit
if [[ ! `polkit-gnome-authentication-agent-1` ]]; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
fi

# start udiskie
udiskie &


/home/eli/.local/bin/fixKeyboard &

/home/eli/.config/polybar/launchbar.sh &

nm-applet &
# blueberry-tray &
optimus-manager-qt &
