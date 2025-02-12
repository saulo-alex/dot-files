#!/bin/bash

# Thanks to lars at https://lars.st0ne.at/blog/switch+between+windows+within+the+same+application

# get id of the focused window
active_win_id=$(xprop -root | grep '^_NET_ACTIVE_W' | awk -F'# 0x' '{print $2}')
if [ "$active_win_id" = "0" ]; then
    active_win_id=""
fi

# get window manager class of current window
win_class=$(wmctrl -x -l | grep $active_win_id | awk '{print $3}' )

# get list of all windows matching with the class above
win_list=$(wmctrl -x -l | grep  $win_class | awk '{print $1}' )

# get next window to focus on
switch_to=$(echo $win_list | sed s/.*$active_win_id// | awk '{print $1}')

# if the current window is the last in the list ... take the first one
if [ "$switch_to" = '' ];then
    switch_to=$(echo $win_list | awk '{print $1}')
fi

# switch to window
wmctrl -i -a $switch_to
