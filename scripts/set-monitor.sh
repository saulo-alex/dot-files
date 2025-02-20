#!/usr/bin/env bash

mode_count=3
mode_files=( $(echo ~/.screenlayout/mode-*.sh) )
mode_descriptions=("Modo de tela com dois monitores" "Modo de tela com apenas monitor externo" "Modo de tela com apenas monitor interno")
current_index_mode=0
user_action=$1
notify_option=$2

function send_notification() {
    notify-send -i /usr/share/icons/Humanity/apps/24/preferences-desktop-display.svg -u low -t 5000 -e -r 1010 "${mode_descriptions[$current_index_mode]}"
}

function set_next_mode() {
    local -i last_index_mode=$(cat ~/.local/share/last-monitor-mode)
    current_index_mode=$(( (last_index_mode + 1) % mode_count ))
    echo "$current_index_mode" > ~/.local/share/last-monitor-mode
    ${mode_files[$current_index_mode]}
}

function set_last_mode() {
    local -i last_index_mode=$(cat ~/.local/share/last-monitor-mode)
    current_index_mode=$last_index_mode
    ${mode_files[$current_index_mode]}
}

if [ "$user_action" == "next" ]; then
    set_next_mode
    [ "$notify_option" == "notify" ] && send_notification 
else
#   user_action=last
    set_last_mode
    [ "$notify_option" == "notify" ] && send_notification
fi

exit 0

