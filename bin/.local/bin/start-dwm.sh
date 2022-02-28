#!/usr/bin/env bash
dunst &
picom &
udiskie &
xwallpaper --zoom  ~/.local/share/wallpaper/*.jpg &
/usr/local/bin/dwmblocks &
unclutter --timeout 15 --jitter 5 --ignore-scrolling
exec dwm

