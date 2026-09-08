set nocompatible
syntax enable
filetype plugin indent on

" ------ Pacotes (via vim-plug) -------
call plug#begin('~/.vim/plugged')
    "Plug 'sheerun/vim-polyglot'
    Plug 'preservim/nerdcommenter'
    Plug 'mattn/emmet-vim'
    Plug 'preservim/tagbar'
    Plug 'alvan/vim-closetag'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    Plug 'ap/vim-css-color'
    Plug 'yegappan/lsp'
    "Plug 'github/copilot.vim'
    " Temas
    Plug 'yasukotelin/shirotelin'
    Plug 'jaredgorski/spacecamp'
    Plug 'chasinglogic/modus-themes-vim'
    Plug 'bdesham/biogoo'
    Plug 'morhetz/gruvbox'
call plug#end()

if has('termguicolors')
    set termguicolors
endif

if has('gui_running')
    "set guioptions-=m  " remove o menu
    set guioptions-=T  " remove o toolbar
    set guioptions-=r  " remove o scroll da direita
    set guioptions-=L  " remove o scroll da esquerda
    set guifont=Cascadia\ Code\ SemiLight\ 9.5
else
    " Configuração de formas do cursor no terminal
    " insert mode
    let &t_SI = "\e[6 q"
    " replace mode
    let &t_SR = "\e[4 q"
    " normal and others mode
    let &t_EI = "\e[2 q"
endif

set statusline=\ Σ\ (#%{%winnr()%})\ %-F\ @\ %n\ %-m%-r\ %=%{FugitiveStatusline()}\ %W%Y\ %l,%c\ %p%%\ [%{&fileencoding}\ %{&fileformat}]\ Σ\ 

" as variáveis precisam ser globais para funcionar no autocmd uma vez que
" elas precisam existir quando ele é chamado
def s:configurelsp(): void
    g:lspopts = {
        autoHighlightDiags: v:true,
        autoComplete: v:false
    }
    autocmd User LspSetup call LspOptionsSet(g:lspopts)

    g:lspservers = [
        {
             name: 'cfamilylang',
             filetype: ['c', 'cpp'],
             path: '/usr/bin/clangd',
             args: ['--background-index']
        },
        {
             name: 'jslang',
             filetype: ['javascript', 'typescript'],
             path: '/usr/bin/typescript-language-server',
             args: ['--stdio']
        },
        {
             name: 'phplang',
             filetype: ['php'],
             path: '/usr/bin/intelephense',
             args: ['--stdio']
        },
    ]
    autocmd User LspSetup call LspAddServer(g:lspservers)
enddef

" Função para verificar se um buffer está vazio
def g:IsBufferEmpty(bufnr: number): bool
    # Obtém todas as linhas do buffer
    var lines: list<string> = getbufline(bufnr, 1, '$')
    # Verifica se todas as linhas estão vazias
    return len(lines) == 1 && empty(lines[0])
enddef

" Função para deletar buffers vazios não ativos
def g:DeleteEmptyBuffers(): void
    # Lista de buffers para deletar
    var buffers_to_delete: list<number> = []

    # Itera sobre todos os buffers abertos
    for buf in getbufinfo({buflisted: 1})
        # Verifica se o buffer está vazio e não está ativo
        if g:IsBufferEmpty(buf.bufnr) && buf.bufnr != bufnr('%')
            buffers_to_delete->add(buf.bufnr)
        endif
    endfor

    # Deleta os buffers vazios
    if !buffers_to_delete->empty()
        execute 'bdelete ' .. buffers_to_delete->join(' ')
        echo 'Buffers vazios deletados: ' .. buffers_to_delete->join(', ')
    else
        echo 'Nenhum buffer vazio encontrado.'
    endif
enddef

" Comando para chamar a função
command! DeleteEmptyBuffers call g:DeleteEmptyBuffers()

" -----------------------------------------------
"                  mapeamentos
" -----------------------------------------------
map <C-s> :write<CR>
imap <C-s> <ESC>:write<CR>a
map <F3> :make<CR>
map <F5> :term<CR>
map <F6> :ls<CR>
map <leader>r :source %<CR>
map <leader>b :bnext!<CR>
map <leader>a :b #<CR>
map <leader>B :bprevious!<CR>
map <leader>D :bdelete!<CR>
map <leader>d :DeleteEmptyBuffers<CR>
map <leader>eo :copen<CR>
map <leader>en :cnext<CR>
map <leader>ep :cprevious<CR>
map <leader>ec :cclose<CR>
map <F8> :Lexplore<CR>
nmap <F9> :TagbarToggle<CR>
" no Windows o CTRL-] para navegar entre tags não funciona!
if exists("$WINDIR")
    map <leader>j :tag <C-r><C-w><CR>
endif
map gF :e <cfile><CR>
" Altera para modo binário
map gh :%!xxd<CR>
" Reverte para modo texto
map gH :%!xxd -r<CR>
map <leader>f :Explo<CR>
map <leader>. 5zh
map <leader>, 5zl
map <leader>k 8k
map <leader>j 8j
map <leader>T :tabnew<CR>
map <leader>l :tabnext<CR>
map <leader>h :tabprevious<CR>

" Quando fechar a janela de preview mate seu buffer
" -- Explicação:
" -- Esse comportamento é mais interessante do que deixar o buffer solto na
" -- lista de buffers, se a janela de preview é para visualização rápida então
" -- ela não deveria sujar seu buffer
map <C-w>z :windo if &previewwindow \| bdelete \| endif \| pclose!<CR>
" Faz alguns comandos do readline (bash) funcionar corretamente
tmap <M-b> <ESC>b
tmap <M-f> <ESC>f
tmap <M-d> <ESC>d
tmap <M-.> <ESC>.
" LSP
map <leader>Ld :LspDiag show<CR>
map <leader>Ldn :LspDiag next<CR>
map <leader>Ldp :LspDiag prev<CR>
map <leader>Ls :LspDocumentSymbol<CR>
map <leader>Lgd :LspGotoDeclaration<CR>
map <leader>LgD :LspGotoDefinition<CR>

map <silent><leader>m :let @/ = ''<CR>
"inoremap ( ()<Left>
"inoremap [ []<Left>
"inoremap { {}<Left>
"inoremap ' ''<Left>
"inoremap " ""<Left>

" ----------------------------------------------
"             ajustes de variáveis
" ----------------------------------------------
" busca melhorar a renderização de grifos longos do UTF-8, reservando o dobro
"  do espaço para um caractere normal ASCII
set history=512
set listchars=tab:>-,eol:$,space:.
set ambiwidth="double"
set redrawtime=1000
" não mova o cursor para o início da linha em determinados comandos como :bn, H, L, :bprev etc.
set nostartofline
set shell=/usr/bin/bash\ --init-file\ ~/.bashrc_vim_term
set foldcolumn=1
set numberwidth=3
set nonumber
" set relativenumber
set wrap
set textwidth=0
set encoding=utf8
set fileencoding=utf8
if strlen(&filetype) == 0
    set filetype=text
endif
set shiftwidth=4
set tabstop=4
set softtabstop=4
" não precisa equalizar as janelas ao abrir uma nova ao redor; desativei a fim
" de :vsplit funcionar normalmente
set noequalalways
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
set updatetime=100
set nobackup
set nowritebackup
set splitright
set splitbelow
" habilita o mouse genericamente
set mouse=a
" habilita o mouse dentro do kitty
set ttymouse=sgr
set ttyfast
set autoread
"set scrolloff=8
set ignorecase
set incsearch
set hlsearch
" quebra linha (com 'wrap') sem quebrar palavras
set linebreak
" caractere que indica que a linha é continuação da última (logicamente) (com 'wrap')
set showbreak=\\_
" set path+=**
set completeopt-=preview

" ---- Linguagens ------
"  Pascal
let pascal_fpc = 1
let pascal_delphi = 0

"  Perl
let g:perl_extended_vars = 1       " Suporte a variáveis complexas
let g:perl_include_pod = 1         " Destaca POD (documentação)
let g:perl_want_scope_in_variables = 1  " Escopo de variáveis
let g:perl_sub_signatures = 1      " Assinaturas de subrotinas

"  C
let g:c_no_curly_error = 1
let g:c_no_bracket_error = 1
let g:c_syntax_for_h = 1      " Trata arquivos .h sempre como C, não C++
let g:is_posix = 1

" -------- Plugins -------
"  Emmet
let g:user_emmet_install_global = 1
let g:user_emmet_leader_key = '<leader>e'
let g:user_emmet_settings = {
\   'variables': {
\       'lang': "pt-br",
\       'locale': "pt-br",
\       'charset': "utf-8",
\   },
\   'html': {
\       'snippets': {
\           '!!': "<!DOCTYPE html>\n<html lang=\"pt-br\">\n<head>\n\t<meta charset=\"utf-8\">\n\t<meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\">\n\t<title>|</title>\n</head>\n<body>\n\n|</body>\n</html>"
\       },
\       'filters': 'html',
\       'default_attributes': {
\           'meta': [{'name': ''}, {'content': ''}],
\       },
\   },
\}

"  Netrw
let g:netrw_winsize = 15
let g:netrw_hide = 1
let g:netrw_banner = 1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 0
let g:netrw_sizestyle = 'H'
let g:netrw_sort_by = 'name'
let g:netrw_sort_sequence = '\/$,\.html$,\.css$,\.js$,\.php\*\=$,\.pl\*\=$,\.pm$,\.md$,\.txt$,\.\(png\|jpeg\|jpg\|gif\|webp\)$,\.py$\*\=$,\.sh\*\=$,\.java$,\.pas$,\.c$,\.cpp$,\.h$,\.hpp$'

"  Copilot
"let g:copilot_enabled = 0

"  LSP 
call s:configurelsp()

" ------ Autocmds
augroup TerminalStatusLine
    autocmd!
    autocmd TerminalWinOpen * setlocal statusline=\ (#%{%winnr()%})\ Terminal\ (on\ bash)\ @\ %n
augroup END

" isso aqui é um bug!
let g:colorscheme = "default"
if $TERM_COLORSCHEME == 'light' || (strftime('H') > 5 && strftime('H') < 18)
    colorscheme biogoo
else
    colorscheme wildcharm
endif
