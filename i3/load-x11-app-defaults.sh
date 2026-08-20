#!/bin/sh

# load all X11 files app-defaults
if [ -d /usr/share/X11/app-defaults ]; then
    for file in /usr/share/X11/app-defaults/*; do
        xrdb -merge "$file"
    done
fi
