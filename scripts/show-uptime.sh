#!/usr/bin/env bash

timestamp=$(cat /proc/uptime | cut -d' ' -f1)

hours=$(bc <<< "$timestamp/3600")
minutes=$(bc <<< "scale=2;m=60*($timestamp/3600-$hours);scale=0;m/1")

echo "Uptime: ${hours}h ${minutes}m"
