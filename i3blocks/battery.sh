#!/usr/bin/env bash

LC_NUMERIC="en_US.UTF-8" 

status=$(cat /sys/class/power_supply/BAT0/status)
full=$(cat /sys/class/power_supply/BAT0/energy_full)
now=$(cat /sys/class/power_supply/BAT0/energy_now)
remaining=$(bc <<< "scale=5; ($now / $full) * 100")

if [ "$status" = "Discharging" ]; then
    printf "Energia: %.2f%% restantes\n" $remaining
else
    printf "Energia: %.2f%% AC\n" $remaining
fi
