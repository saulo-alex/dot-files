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
    "Plug 'tpope/vim-surround'
    Plug 'tpope/vim-fugitive'
    "Plug 'tpope/vim-rhubarb'
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

" -----------------
"  Previne o vim de sair usando C-q indevidamente ao fechar janelas
"  Nota: a função deve não pode ser local uma vez que será usada com :map
function! PreventExit()
    if winnr('$') > 1 || tabpagenr('$') > 1 || confirm('Você deseja realmente sair?', '&Sim'."\n".'&Não') == 1
        quit
    endif
endfunction

function! FindAllColorschemes()
    let g:colorschemes = []
    let l:directories = split(&runtimepath, ',')

    for l:directory in l:directories
        let l:targets = split(glob(l:directory .. '/colors/*.vim'), "\n")
        if len(l:targets) > 0
            for l:target in l:targets
                let l:matches = matchlist(l:target, '/\([^/]\+\)\.vim$')
                let g:colorschemes = add(g:colorschemes, l:matches[1])
            endfor
        endif
    endfor

    let g:colorschemes = sort(g:colorschemes)
endfunction

function! PreviousColorScheme()
    " Poderia utilizar a variável g:colors_name ou mesmo
    " execute('colorscheme') porém alguns temas armazenam nessas variáveis
    " nomes diferentes do nome do arquivo deles, e como :colorscheme depende
    " do nome do arquivo, o script falharia nessas circustâncias, então
    " prefiri utilizar uma variável a parte para não depender disso.
    let l:index = index(g:colorschemes, g:colorscheme.name, g:colorscheme.index)
    let l:newIndex = l:index - 1
    
    if l:newIndex < 0
        let l:newIndex = len(g:colorschemes) - 1
    endif
    let g:colorscheme.name = g:colorschemes[l:newIndex]

    execute('colorscheme ' .. g:colorscheme.name)
    let g:colorscheme.index = l:newIndex
    " redraw é necessário para evitar que a mensagem seja limpa antes
    "  de ser visualizada pelo usuário após o refresh automático da tela
    redraw | echom "Tema definido para" g:colorscheme.name g:colorscheme.index
endfunction

function! NextColorScheme()
    " Poderia utilizar a variável g:colors_name ou mesmo
    " execute('colorscheme') porém alguns temas armazenam nessas variáveis
    " nomes diferentes do nome do arquivo deles, e como :colorscheme depende
    " do nome do arquivo, o script falharia nessas circustâncias, então
    " prefiri utilizar uma variável a parte para não depender disso.
    let l:index = index(g:colorschemes, g:colorscheme.name, g:colorscheme.index)
    let l:newIndex = l:index + 1
    
    if l:newIndex >= len(g:colorschemes)
        let l:newIndex = 0
    endif
    let g:colorscheme.name = g:colorschemes[l:newIndex]

    execute('colorscheme ' .. g:colorscheme.name)
    let g:colorscheme.index = l:newIndex
    " redraw é necessário para evitar que a mensagem seja limpa antes
    "  de ser visualizada pelo usuário após o refresh automático da tela
    redraw | echom "Tema definido para" g:colorscheme.name g:colorscheme.index
endfunction

function! ChangeFontSize(o)
    let l:fontsize = matchstr(&guifont, '\d\+$')
    let l:fontname = matchstr(&guifont, '^[a-zA-Z ]\+')

    if (a:o == '+')
        let l:fontsize = str2nr(l:fontsize) + 1 
    else
        let l:fontsize = str2nr(l:fontsize) - 1
    endif

    let l:actualfont = l:fontname . l:fontsize

    echom "Setando a fonte: " . l:actualfont

    execute "set guifont=" . substitute(l:actualfont, '\([ ]\)', '\\\1', 'g')
endfunction

" Chamada quando executa :colorscheme <nome> afim de atualizar as minhas
" variáveis de tema
function! ForceUpdateColorScheme(name)
    let g:colorscheme.name = a:name 
    let g:colorscheme.index = index(g:colorschemes, a:name)
endfunction

function! ApplyTheme()
    let g:colorscheme = #{name: '', index: 0}
    if has('termguicolors')
        set termguicolors
    endif

    if has('gui_running')
        "set guioptions-=m  " remove o menu
        set guioptions-=T  " remove o toolbar
        set guioptions-=r  " remove o scroll da direita
        set guioptions-=L  " remove o scroll da esquerda
        "set guifont=Hack\ Nerd\ Font\ Mono\ Regular\ 9.5
        set guifont=Cascadia\ Code\ SemiLight\ 9.5
        "set guifont=Cousine\ Nerd\ Font\ Mono\ 9
    endif

    let s:hour_now = strftime("%H")
    let s:minute_now = strftime("%M")

    set statusline=\ Σ\ (#%{%winnr()%})\ %-F\ @\ %n\ %-m\ %=%{FugitiveStatusline()}\ %R%W%Y\ %l,%c\ %p%%\ [%{&fileencoding}\ %{&fileformat}]\ Σ\ 

    "set statusline=\ Σ\ (#%{%winnr()%})\ %-F\ @\ %n\ %-m%=\ %R%W%Y\ %l,%c\ %p%%\ [%{&fileencoding}\ %{&fileformat}]\ Σ\ 
    " ---- Dia: entre 7h as 17h15
    if s:hour_now >= 7 && s:hour_now < 17 || (s:hour_now == 17 && s:minute_now <= 15)
        if has('gui_running')
            let g:colorscheme.name = 'eclipse'
            let g:colorscheme.index = index(g:colorschemes, g:colorscheme.name)
            execute('colorscheme ' .. g:colorscheme.name)
            set background=light
        else
            colorscheme black
            set background=dark
        endif
    else
        colorscheme black
        set background=dark
        "let g:colorscheme.name = 'wildcharm'
        "let g:colorscheme.index = index(g:colorschemes, g:colorscheme.name)
        "execute('colorscheme ' .. g:colorscheme.name)
        "set background=dark
    endif
    "highlight ModeMsg term=bold ctermfg=white ctermbg=darkred
    "highlight Normal guibg=NONE ctermbg=NONE
endfunc

function! SetupLangServers()
    " as variáveis precisam ser globais para funcionar no autocmd uma vez que
    " elas precisam existir quando ele é chamado
    let g:lspOptions = {'autoHighlightDiags': v:true, 'autoComplete': v:false}
    autocmd User LspSetup call LspOptionsSet(g:lspOptions)

    let g:lspServers = [{
                \           'name': 'cfamilylang',
                \           'filetype': ['c', 'cpp'],
                \           'path': '/usr/bin/clangd',
                \           'args': ['--background-index']
                \      },
                \      {
                \           'name': 'jslang',
                \           'filetype': ['javascript', 'typescript'],
                \           'path': '/usr/bin/typescript-language-server',
                \           'args': ['--stdio']
                \      },
                \      {
                \           'name': 'phplang',
                \           'filetype': ['php'],
                \           'path': '/usr/bin/intelephense',
                \           'args': ['--stdio']
                \      },
                \     ]
    autocmd User LspSetup call LspAddServer(g:lspServers)
endfunction

" Função para verificar se um buffer está vazio
function! IsBufferEmpty(bufnr) abort
    " Obtém todas as linhas do buffer
    let lines = getbufline(a:bufnr, 1, '$')
    " Verifica se todas as linhas estão vazias
    return len(lines) == 1 && empty(lines[0])
endfunction

" Função para deletar buffers vazios não ativos
function! DeleteEmptyBuffers() abort
    " Lista de buffers para deletar
    let buffers_to_delete = []

    " Itera sobre todos os buffers abertos
    for buf in getbufinfo({'buflisted': 1})
        " Verifica se o buffer está vazio e não está ativo
        if IsBufferEmpty(buf.bufnr) && buf.bufnr != bufnr('%')
            call add(buffers_to_delete, buf.bufnr)
        endif
    endfor

    " Deleta os buffers vazios
    if !empty(buffers_to_delete)
        execute 'bdelete ' . join(buffers_to_delete, ' ')
        echo 'Buffers vazios deletados: ' . join(buffers_to_delete, ', ')
    else
        echo 'Nenhum buffer vazio encontrado.'
    endif
endfunction

" Comando para chamar a função
command! DeleteEmptyBuffers call DeleteEmptyBuffers()

" -----------------------------------------------
"                  mapeamentos
" -----------------------------------------------
map <C-s> :write!<CR>
imap <C-s> <ESC>:write!<CR>a
map <F3> :make<CR>
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
map <leader>eo :copen<CR>
map <leader>en :cnext<CR>
map <leader>ep :cprevious<CR>
map <leader>ec :cclose<CR>
map <F8> :Lexplore 12<CR>
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
set redrawtime=1000
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
"set autoread
"set scrolloff=8
set incsearch
set hlsearch

" set path+=**

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
let pascal_delphi=0

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
\       'snippets': {
\           '!!': "<!DOCTYPE html>\n<html lang=\"pt-br\">\n<head>\n\t<meta charset=\"utf-8\">\n\t<meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\">\n\t<title>|</title>\n</head>\n<body>\n\n|</body>\n</html>"
\       },
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

" Compreenda as features modernas do Perl
let g:perl_extended_vars = 1       " Suporte a variáveis complexas
let g:perl_include_pod = 1         " Destaca POD (documentação)
let g:perl_want_scope_in_variables = 1  " Escopo de variáveis
let g:perl_sub_signatures = 1      " Assinaturas de subrotinas

" C23 por padrão
let g:c_no_curly_error = 1
let g:c_no_bracket_error = 1
let g:c_syntax_for_h = 1      " Trata arquivos .h sempre como C, não C++
let g:is_posix = 1
