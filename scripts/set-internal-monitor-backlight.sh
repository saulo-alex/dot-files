#!/usr/bin/env bash

declare -ri step=5
declare -ri delay=2000
declare -i current

current=$(echo $(xbacklight -get)/1 | bc)
echo "O brilho atual do monitor interno está em $current%"

if [ "$1" = "+" ]; then
    new_value=$((current+step))
    [ "$new_value" -gt 100 ] && new_value=100
else
    new_value=$((current-step))
    [ "$new_value" -lt 0 ] && new_value=0
fi

xbacklight -set $new_value
echo "O novo brilho do monitor interno está agora em $new_value%"
if [ -n "$2" ] && [ "$2" = notify ]; then
    notify-send -u low -t $delay -e -r 1020 -i /usr/share/icons/gnome/32x32/devices/xfce4-display.png "O brilho do monitor interno é agora $new_value%"

fi
echo "$new_value%" > ~/.local/share/backlight-internal
