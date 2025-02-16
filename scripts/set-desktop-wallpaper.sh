#!/usr/bin/env bash

hour=$(date +"%H" | bc)

if [[ "$hour" -ge 6 && "$hour" -lt 18 ]]; then
    feh --bg-fill "$(echo ~/Imagens/FHD/Light/* | tr ' ' '\n' | shuf -n1)" --bg-fill "$(echo ~/Imagens/HD/Light/* | tr ' ' '\n' | shuf -n1)"
else
    feh --bg-fill "$(echo ~/Imagens/FHD/Dark/* | tr ' ' '\n' | shuf -n1)" --bg-fill "$(echo ~/Imagens/HD/Dark/* | tr ' ' '\n' | shuf -n1)"
fi
