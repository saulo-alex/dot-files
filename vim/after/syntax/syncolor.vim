if &background == "light"
else
    if g:colorscheme['name'] ==# 'oceanblack'
        " marcação de arquivo no netrw
        highlight TabLineSel gui=underline guifg=#f2a2a2
        hi StatusLineNC term=bold cterm=bold gui=bold guifg=white guibg=black
        hi StatusLine term=bold cterm=bold gui=bold guifg=black guibg=white
    endif
endif
