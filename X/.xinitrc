#!/bin/bash

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

unclutter --timeout 15 &
/usr/bin/prime-offload
/home/eli/.local/bin/fixKeyboard
# uncomment this if you want to use cinnamon
# exec cinnamon-session
dwm

/usr/bin/prime-switch

