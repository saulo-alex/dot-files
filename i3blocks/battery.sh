#!/usr/bin/env bash

status=$(cat /sys/class/power_supply/BAT0/status)
full=$(cat /sys/class/power_supply/BAT0/energy_full)
now=$(cat /sys/class/power_supply/BAT0/energy_now)
remaining=$(bc <<< "scale=5; ($now / $full) * 100")

if [ "$status" = "Discharging" ]; then
    /usr/bin/printf "Energia: %'.2f%% restantes\n" $remaining
else
    /usr/bin/printf "Energia: %'.2f%% AC\n" $remaining
fi
