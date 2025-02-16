#!/usr/bin/env bash

declare -ri step=5
declare -ri delay=2000
declare -ri property=10
declare -i current

current=$(ddcutil getvcp 10 | sed -n 's/\(.*current value =[[:blank:]]\+\([0-9]\+\).*\)/\2/p')
echo "O brilho atual do monitor externo está em $current%"

if [ "$1" = "+" ]; then
    new_value=$((10#$current+step))
    [ "$new_value" -gt 100 ] && new_value=100
else
    new_value=$((10#$current-step))
    [ "$new_value" -lt 0 ] && new_value=0
fi

ddcutil setvcp $property $new_value
echo "O novo brilho do monitor externo está agora em $new_value%"
if [ -n "$2" ] && [ "$2" = notify ]; then
    notify-send -u low -t $delay -e -r 1020 -i /usr/share/icons/gnome/32x32/devices/xfce4-display.png "O brilho do monitor externo é agora $new_value%"
fi
echo "$new_value%" > ~/.local/share/backlight-external
