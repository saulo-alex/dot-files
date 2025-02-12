#!/bin/bash

# ------------------------------------------------------------------------
#
# O script abaixo altera entre o tema claro e o escuro do Greybird no XFCE
# A ideia é que ele funcione em algum agendador de tarefas como o cron
#
# Obs.: Para aplicar no QT também é necessário a ferramenta qt5ct instalada
# 
# Jan/24 - Saulo Alex
#
# ------------------------------------------------------------------------

# o tema necessita de uma sessão ativa no xfce
if ! pgrep -x "xfce4-session" >/dev/null 2>&1; then
    echo 2> "Erro: O XFCE deve estar rodando para o tema ser aplicado."
    exit
fi

#xfwm_theme_light="Greybird-dark"
#xfwm_theme_dark="Greybird-dark"
xfwm_theme_light="Waza"
xfwm_theme_dark="Waza"

gtk_theme_light="Greybird"
gtk_theme_dark="Greybird-dark"

#gtk_theme_light="Zukitre"
#gtk_theme_dark="Zukitre-dark"

qt_theme_light="Breeze"
qt_theme_dark="Breeze"
qt_icon_light="breeze"
qt_icon_dark="breeze-dark"
qt_config_path="/home/$USER/.config/qt6ct/qt6ct.conf"

icon_theme_light="elementary-xfce"
icon_theme_dark="elementary-xfce"

wallpaper_external_path_light="/home/saulo/Imagens/FHD/Light"
wallpaper_external_path_dark="/home/saulo/Imagens/FHD/Dark"
wallpaper_internal_path_light="/home/saulo/Imagens/HD/Light"
wallpaper_internal_path_dark="/home/saulo/Imagens/HD/Dark"

change_wallpaper() {
    variation=$1
    wallpaper=""

    if [ "$variation" == "light" ]; then
        # o asteriscos no caminho serve para forçar a lista possuir o caminho absoluto
        wallpaper=$(ls "$wallpaper_external_path_light"/* | shuf | head -n1)
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI1/workspace0/last-image -s "$wallpaper"
        wallpaper=$(ls "$wallpaper_internal_path_light"/* | shuf | head -n1)
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorLVDS1/workspace0/last-image -s "$wallpaper"
    else
        wallpaper=$(ls "$wallpaper_external_path_dark"/* | shuf | head -n1)
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorHDMI1/workspace0/last-image -s "$wallpaper"
        wallpaper=$(ls "$wallpaper_internal_path_dark"/* | shuf | head -n1)
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorLVDS1/workspace0/last-image -s "$wallpaper"
    fi

    xfdesktop --reload
}

hour=$(date +"%H")

if [ $hour -ge 6 ] && [ $hour -le 17 ]; then
    # altera no qt primeiro usando o arquivo de conf do qt5ct
    #sed -i 's#\(^color_scheme_path=\)\(.*\)#\1'"$qt_theme_path_light"'#' "$qt_config_path"
    sed -i '/^style=/s#'"$qt_theme_dark"'$#'"$qt_theme_light"'#' "$qt_config_path"
    sed -i '/^icon_theme=/s#'"$qt_icon_dark"'$#'"$qt_icon_light"'#' "$qt_config_path"
    sed -i '/^custom_palette=/s#true#false#' "$qt_config_path"
    sed -i '/^stylesheets=/s#/home/saulo/.config/qt6ct/qss/kcalc-dark-breeze.qss#@Invalid()#' "$qt_config_path"
    sed -i '/^color_scheme_path=/s#/usr/share/qt6ct/colors/darker.conf#@Invalid()#' "$qt_config_path"

    # se já estiver sido setado o tema gtk correspondente, evite esforço...
    [ $(xfconf-query -c xsettings -p /Net/ThemeName) == "$gtk_theme_light" ] && exit
    # define o tema do xfwm
    xfconf-query -c xfwm4 -p /general/theme -s "$xfwm_theme_light"
    # define o tema do gtk
    xfconf-query -c xsettings -p /Net/ThemeName -s "$gtk_theme_light"
    # define o tema dos ícones
    xfconf-query -c xsettings -p /Net/IconThemeName -s "$icon_theme_light"
    # define o papel de parede
    change_wallpaper "light"
else
    # altera no qt primeiro usando o arquivo de conf do qt6ct
    #sed -i 's#\(^color_scheme_path=\)\(.*\)#\1'"$qt_theme_path_dark"'#' "$qt_config_path"
    sed -i '/^style=/s#'"$qt_theme_light"'$#'"$qt_theme_dark"'#' "$qt_config_path"
    sed -i '/^icon_theme=/s#'"$qt_icon_light"'$#'"$qt_icon_dark"'#' "$qt_config_path"
    sed -i '/^custom_palette=/s#false#true#' "$qt_config_path"
    sed -i '/^color_scheme_path=/s#@Invalid()#/usr/share/qt6ct/colors/darker.conf#' "$qt_config_path"
    sed -i '/^stylesheets=/s#@Invalid()#/home/saulo/.config/qt6ct/qss/kcalc-dark-breeze.qss#' "$qt_config_path"
    # se já estiver sido setado o tema gtk correspondente, evite esforço...
    [ $(xfconf-query -c xsettings -p /Net/ThemeName) == "$gtk_theme_dark" ] && exit
    # define o tema do xfwm
    xfconf-query -c xfwm4 -p /general/theme -s "$xfwm_theme_dark"
    # define o tema do gtk
    xfconf-query -c xsettings -p /Net/ThemeName -s "$gtk_theme_dark"
    # define o tema dos ícones
    xfconf-query -c xsettings -p /Net/IconThemeName -s "$icon_theme_dark"
    # define o papel de parede
    change_wallpaper "dark"
fi

