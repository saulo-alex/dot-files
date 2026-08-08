#!/bin/bash

eval $(tmux show-environment -s TERM_COLORSCHEME)

if [ "$TERM_COLORSCHEME" = 'light' ]; then
    tmux run-shell "notify-send 'Tmux' 'Carregado modo claro no tmux'"
    tmux source-file ~/.tmux-theme-light.conf
    tmux set default-command 'bash --rcfile ~/.bashrc_light'
else
    tmux run-shell "notify-send 'Tmux' 'Carregado modo escuro no tmux'"
    tmux source-file ~/.tmux-theme-dark.conf
    tmux set default-command 'bash --rcfile ~/.bashrc_dark'
fi
