#!/usr/bin/env bash

# Converte para int
actual=$(echo $(xbacklight -get)/1 | bc )
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

xbacklight -set "$new_value"%

echo "O novo valor do brilho é $new_value"
# notify-send "Monitor interno" "O brilho agora é $new_value%" -e -u low -t 750
echo "$new_value%" > ~/.local/share/backlight-internal
