#!/usr/bin/env bash

declare output
declare uptimestatus
declare timestamp
declare -a options

options=("${@:1}")
for option in "${options[@]}"; do
    case "$option" in
        "--full")
            output="Uptime: "
            ;;
        "--simple")
            output=""
    esac
done

timestamp=$(awk -F. '{print $1}' /proc/uptime)
# Para segundos adicione $((timestamp % 60)))
uptimestatus="$((timestamp / 3600))h $(((timestamp % 3600) / 60))m"
output="${output}${uptimestatus}"

echo "$output"
