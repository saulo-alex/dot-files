#!/usr/bin/env bash

property=10
# actual=$(ddcutil getvcp $property | cut -f3 -d\t | cut -f1 -d, | cut -f2 -d= | sed -e 's/\s\+//g')
# actual=$(ddcutil getvcp $property | sed -e 's/\s\+)/)/g' | sed -e "s/\s\{2,\}\|,/ /g" | cut -d' ' -f8)
actual=$(ddcutil getvcp $property | tail -n1 | tr -s ' ' | cut -d, -f1 | cut -d= -f2)
step=5

echo "O valor atual do brilho é $actual"

if [ "$1" = "+" ]; then
	new_value=$(echo $actual + $step | bc)
elif [ "$1" = "-" ]; then
	new_value=$(echo $actual - $step | bc)
fi

if [ "$new_value" -gt 100 ]; then
	new_value=100
elif [ "$new_value" -lt 0 ]; then
	new_value=0
fi

ddcutil setvcp $property $new_value

echo "O novo valor do brilho é $new_value"
# notify-send "Monitor externo" "O brilho agora é $new_value%" -e -u low -t 750
#
echo "$new_value%" > ~/.local/share/backlight-external
