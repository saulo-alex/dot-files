#!/usr/bin/env bash

modes=( $(echo ~/.screenlayout/mode-*) )
descriptions=("Modo de tela com dois monitores" "Modo de tela com apenas monitor externo" "Modo de tela com apenas monitor interno")
modes_count=${#modes[*]}
current=$(cat ~/.local/share/current-mode-monitor)
new_current=$(( (current+1) % modes_count ))
${modes[$new_current]}
notify-send -i /usr/share/icons/Humanity/apps/24/preferences-desktop-display.svg -u low -t 5000 -e -r 1010 "${descriptions[$new_current]}"
echo "$new_current" > ~/.local/share/current-mode-monitor

