" -------- sintaxe highlight --------
syntax enable

" -------- detecção de configurações por linguagem --------
filetype plugin indent on

" -----------------------------------------------
"                  mapeamentos
" -----------------------------------------------
map <C-s> :write!<CR>
imap <C-s> <ESC>:write!<CR>a
map <F5> :shell<CR>
map <leader>b :bnext!<CR>
map <leader>B :bprevious!<CR>
map <leader>D :bdelete!<CR>
" no Windows o CTRL-] para navegar entre tags não funciona!
if exists("$WINDIR")
    map <leader>j :tag <C-r><C-w><CR>
endif

" ----------------------------------------------
"             ajustes de variáveis
" ----------------------------------------------
set number
set nowrap
set encoding=utf8
set shiftwidth=4
set tabstop=4
set softtabstop=4
set showcmd
set laststatus=2
set expandtab
set backspace=indent,eol,start
set autoindent
set wildmenu
set wildmode=full

set statusline=\ ≡\ [%-{toupper(&filetype)}]\ [%n]\ “%-F”\ %=\ ♫\ %m%r\ %l:%L\ %c\ [%{&fileencoding}\ %{&fileformat}]\ ≡\ 

if has("gui_running")
    "set guioptions-=m  " remove o menu
    "set guioptions-=T  " remove o toolbar
    "set guioptions-=r  " remove o scroll da direita
    "set guioptions-=L  " remove o scroll da esquerda
    " ------ configuração do tema ------
    "colorscheme shirotelin
    set guifont=Consolas:h10.5:qCLEARTYPE
endif
