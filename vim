" --------- Elementares -------------
set nocompatible
syntax enable
filetype plugin indent on

 " ------- Plugins (via vim-plug) --------
call plug#begin('~/.vim/plugged')
    Plug 'sheerun/vim-polyglot'
    Plug 'preservim/nerdcommenter'
    Plug 'mattn/emmet-vim'
    Plug 'preservim/tagbar'
    Plug 'alvan/vim-closetag'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    "Plug 'pulkomandy/c.vim'
    "Plug 'vim-ruby/vim-ruby'
    " Colorizer breaks when set notermguicolors, using vim-css-color is better
    "Plug 'chrisbra/Colorizer'
    Plug 'ap/vim-css-color'
    "Plug 'amadeus/vim-css'
    " LSP plugin (servidores das linguagens são à parte)
    Plug 'yegappan/lsp'

    " Temas
    Plug 'yasukotelin/shirotelin'
    Plug 'haystackandroid/vimspectr'
    Plug 'nanotech/jellybeans.vim'
    Plug 'jaredgorski/spacecamp'
    Plug 'cormacrelf/vim-colors-github'
    Plug 'chasinglogic/modus-themes-vim'
    Plug 'bdesham/biogoo'
    Plug 'morhetz/gruvbox'
    Plug 'ayu-theme/ayu-vim'
    Plug 'trapd00r/neverland-vim-theme'
    Plug 'marcopaganini/mojave-vim-theme'
    Plug 'luckydev/150colors'
    Plug 'dracula/vim', { 'name': 'dracula' }
call plug#end()

" Tudo auxiliar está aqui (incluindo temas)
source ~/.vimrc_functions

" -----------------------------------------------
"                  mapeamentos
" -----------------------------------------------
map <C-s> :write!<CR>
imap <C-s> <ESC>:write!<CR>a
map <F5> :term<CR>
map <F6> :ls<CR>
map <leader>r :source %<CR>
map <leader><C-p> :call PreviousColorScheme()<CR>
map <leader><C-n> :call NextColorScheme()<CR>
map <leader>b :bnext!<CR>
map <leader>a :b #<CR>
map <leader>B :bprevious!<CR>
map <leader>D :bdelete!<CR>
map <leader>d :DeleteEmptyBuffers<CR>
map <F8> :Lexplore 10<CR>
nmap <F9> :TagbarToggle<CR>
" no Windows o CTRL-] para navegar entre tags não funciona!
if exists("$WINDIR")
    map <leader>j :tag <C-r><C-w><CR>
endif
map gF :e <cfile><CR>
map <silent> <C-w>q :call PreventExit()<CR>
map <leader>f :Explo<CR>
map <leader>. 5zh
map <leader>, 5zl
map <leader>k 8k
map <leader>j 8j
map <leader>T :tabnew<CR>
map <leader>l :tabnext<CR>
map <leader>h :tabprevious<CR>
if has("gui_running")
    map <silent> <leader>[ :call ChangeFontSize('+')<CR>
    map <silent> <leader>] :call ChangeFontSize('-')<CR>
endif
" Quando fechar a janela de preview mate seu buffer
" -- Explicação:
" -- Esse comportamento é mais interessante do que deixar o buffer solto na
" -- lista de buffers, se a janela de preview é para visualização rápida então
" -- ela não deveria sujar seu buffer
map <C-w>z :windo if &previewwindow \| bdelete \| endif \| pclose!<CR>
map [[ ?{<CR>w99[{
map ]] j0[[%/{<CR>

" LSP
map <leader>Ld :LspDiag show<CR>
map <leader>Ldn :LspDiag next<CR>
map <leader>Ldp :LspDiag prev<CR>
map <leader>Ls :LspDocumentSymbol<CR>
map <leader>Lgd :LspGotoDeclaration<CR>
map <leader>LgD :LspGotoDefinition<CR>

map <silent><leader>m :let @/ = ''<CR>

" ----------------------------------------------
"             ajustes de variáveis
" ----------------------------------------------
" busca melhorar a renderização de grifos longos do UTF-8, reservando o dobro
"  do espaço para um caractere normal ASCII
set listchars=tab:>-,eol:$,space:.
set ambiwidth="double"
set redrawtime=2500
" não mova o cursor para o início da linha em determinados comandos como :bn, H, L, :bprev etc.
set nostartofline
set shell=/usr/bin/bash\ --init-file\ ~/.bashrc_vim_term
set foldcolumn=1
set numberwidth=3
set number
"set nowrap
set encoding=utf8
set fileencoding=utf8
if strlen(&filetype) == 0
    set filetype=text
endif
set shiftwidth=4
set tabstop=4
set softtabstop=4
set showcmd
set laststatus=2
set expandtab
set smarttab
set smartindent
set hidden
set backspace=indent,eol,start
set autoindent
set wildmenu
set wildmode=full
"set colorcolumn=100
"set cmdheight=2
"set updatetime=100
set nobackup
set nowritebackup
set splitright
set splitbelow
" habilita o mouse genericamente
set mouse=a
" habilita o mouse dentro do kitty
set ttymouse=sgr
"set autoread
"set scrolloff=8
set incsearch
set hlsearch

set path+=**

if !has("gui_running")
    " Configuração de formas do cursor no terminal
    " insert mode
    let &t_SI = "\e[6 q"
    " replace mode
    let &t_SR = "\e[4 q"
    " normal and others mode
    let &t_EI = "\e[2 q"
endif

" Sintaxe do pascal (outra útil pascal_delphi)
let pascal_fpc=1
let pascal_delphi=1

" ------------------ Configuração do Emmet --------------------
let g:user_emmet_install_global = 1
let g:user_emmet_leader_key='<leader>e'
let g:user_emmet_settings = {
\   'variables': {
\       'lang': "pt-br",
\       'locale': "pt-br",
\       'charset': "utf-8",
\   },
\   'html': {
\       'filters': 'html',
\       'default_attributes': {
\           'meta': [{'name': ''}, {'content': ''}],
\       },
\   },
\}


" ------------------ Configuração do netrw --------------------
let g:netrw_hide = 1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_sizestyle = 'H'
let g:netrw_sort_by = 'name'
let g:netrw_sort_sequence = '\/$,\.html$,\.css$,\.js$,\.php\*\=$,\.pl\*\=$,\.pm$,\.md$,\.txt$,\.\(png\|jpeg\|jpg\|gif\|webp\)$,\.py$\*\=$,\.sh\*\=$,\.java$,\.pas$,\.c$,\.cpp$,\.h$,\.hpp$'

" Desabilitar o highlight de match de parênteses e similares
let g:loaded_matchparen=1

" --------------- Configuração do Colorizer -----------------
let g:colorizer_auto_filetype = 'sass,css,html'
let g:colorizer_skip_comments = 1

call FindAllColorschemes()

" Deve ser chamada após FindAllColorschemes()
call ApplyTheme()

" Deve ser definido após ApplyTheme() por causa da não-existência de g:colorscheme
autocmd! ColorScheme * let m = expand("<amatch>") |
            \ execute('call ForceUpdateColorScheme(m)') 

" Configura os servidores das linguagens
call SetupLangServers()

set completeopt-=preview
