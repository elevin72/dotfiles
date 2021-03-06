#!/bin/sh

# Show wifi đļ and percent strength or đĄ if none.
# Show đ if connected to ethernet or â if none.
# Show đ if a vpn connection is active

case $BLOCK_BUTTON in
	1) gnome-control-center wifi; pkill -RTMIN+4 dwmblocks ;;
	3) notify-send "đ Internet module" "\- Click to connect
īĒŠ: no wifi connection
īĒ¨: wifi connection with quality
â: no ethernet
đ: ethernet working
đ: vpn is active
" ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
	down) wifiicon="īĒŠ " ;;
	up) wifiicon="$(awk '/^\s*w/ { print "īĒ¨", int($3 * 100 / 70) "% " }' /proc/net/wireless)" ;;
esac
# sed -i  "1s/.*/$wifiicon/" ~/.local/share/wifiStatus
# getstatus=$(sed -n '1p' < ~/.local/share/wifiStatus)

printf "%s%s%s\n" "$wifiicon"

