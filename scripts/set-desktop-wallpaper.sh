#!/usr/bin/env bash

# Modos: automático (garante o tema escuro à noite e o tema claro de dia): --auto; manual: --dark (escuro) ou --light (claro)

declare -A options
declare rootpath="$HOME/Imagens"

large_dark_wallpapers=($rootpath/FHD/Dark/*)
large_light_wallpapers=($rootpath/FHD/Light/*)
small_dark_wallpapers=($rootpath/HD/Dark/*)
small_light_wallpapers=($rootpath/HD/Light/*)

function get_opts() {
    flags=("${@:1}")
    for flag in "${flags[@]}"; do
        if [[ "$flag" == "--auto" || "$flag" == "--dark" || "$flag" == "--light" ]]; then
            if [ "$flag" == "--auto" ]; then
                hour=$(date +"%H" | bc)
                # light
                if [[ "$hour" -ge 6 && "$hour" -lt 18 ]]; then
                    options["theme"]="light"
                else # dark
                    options["theme"]="dark"
                fi
            elif [ "$flag" == "--dark" ]; then
                options["theme"]="dark"
            elif [ "$flag" == "--light" ]; then
                options["theme"]="light"
            fi
        fi
    done
}

function set_wallpaper() {
    if [ "${options[theme]}" == "light" ]; then
        large_choice=$((RANDOM % ${#large_light_wallpapers[@]}))
        small_choice=$((RANDOM % ${#small_light_wallpapers[@]}))
        feh --bg-fill "${large_light_wallpapers[$large_choice]}" --bg-fill "${small_light_wallpapers[$small_choice]}"
    elif [ "${options[theme]}" == "dark" ]; then
        large_choice=$((RANDOM % ${#large_dark_wallpapers[@]}))
        small_choice=$((RANDOM % ${#small_dark_wallpapers[@]}))
        feh --bg-fill "${large_dark_wallpapers[$large_choice]}" --bg-fill "${small_dark_wallpapers[$small_choice]}"
    fi
}

get_opts "$@"

set_wallpaper 

