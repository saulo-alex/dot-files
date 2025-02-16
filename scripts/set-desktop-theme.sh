#!/usr/bin/env bash

hour=$(date +'%H' | bc)

if [[ "$hour" -ge 5 && "$hour" -lt 18 ]]; then
    gsettings set org.gnome.desktop.interface gtk-theme Greybird
    cat ~/.gtk3-light > ~/.config/gtk-3.0/settings.ini
    cat ~/.gtk2-light > ~/.gtkrc-2.0
    cat ~/.qt6ct-light > ~/.config/qt6ct/qt6ct.conf
else
    gsettings set org.gnome.desktop.interface gtk-theme Greybird-dark
    cat ~/.gtk3-dark > ~/.config/gtk-3.0/settings.ini
    cat ~/.gtk2-dark > ~/.gtkrc-2.0
    cat ~/.qt6ct-dark > ~/.config/qt6ct/qt6ct.conf
fi

