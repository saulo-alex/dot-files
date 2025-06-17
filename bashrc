#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ---------------------
# Funções utilitárias
# ---------------------

show_last_status() {
    local laststatus=$(echo $?)
    local colored_laststatus=""
    local green_color="\e[92m"
    local red_color="\e[91m"
    local reset_color="\e[0m"

    if [ $laststatus -eq 0 ]; then
        colored_laststatus="${green_color}(${laststatus})${reset_color}"
    else
        colored_laststatus="${red_color}(${laststatus})${reset_color}"
    fi

    echo -e "$colored_laststatus"
}

# ---------------------
# Apelidos (alias)
# ---------------------

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vimview='vim -c "set readonly | set nomodifiable"'
alias xpdf='xpdf -style Fusion -aa yes -aaVector yes'

# ------------------------------------------------------------------------
# Alguns caracteres de controle interpolados pelo $PS1 do Bash:
# \d (data)
# \e (escapa o próximo caractere)
# \h (hostname)
# \n (nova linha)
# \A (hora em formato 24h)
# \u (usuário)
# \w ($PWD com home abreviado para ~)
# \$ (# root ou $ usuário comum)
# \[ (início de de uma sequência de caracteres não-visíveis, como coloração!)
# \] (fim de uma sequência de caracteres não-visíveis)
#
# Formato de cores (Código de escape ANSI):
# Leia: https://en.wikipedia.org/wiki/ANSI_escape_code
#
# \e[N m , onde:
#  N é um ou mais números separados por ponto-e-vírgula que representam
#     os comandos ANSI
#  m é o delimitador de fim da sequência de escape
#  Obs.: Mesmo em múltiplos comandos, apenas um único m é necessário!
#
# Comandos gerais:
#  0 - reseta, ou volta ao normal
#
# Comandos de fonte:
#  1 - ativa negrito ou aumenta intensidade do brilho
#  2 - ativa apagado ou diminui intensidade do brilho
#  3 - ativa itálico
#  4 - ativa underline
#  5 - ativa piscar lento (normalmente, 5 e 6 são iguais)
#  6 - ativa piscar rápido
#  7 - ativa modo reverso
#  8 - ativa texto invisível (bg é mantido)
#  9 - ativa strike (linha horizontal cortando)
#  10 - ativa fonte default
#
#  11 a 19 - fonte alternativa
#  20 - fonte gótica (normalmente não suportado)
#
#  21 - desativa negrito ou aumenta intensidade do brilho
#  22 - desativa apagado ou diminui intensidade do brilho
#  23 - desativa itálico
#  24 - desativa underline
#  25 - desativa piscar lento (normalmente, 5 e 6 são iguais)
#  26 - desativa piscar rápido
#  27 - desativa modo reverso
#  28 - desativa texto invisível (bg é mantido)
#  29 - desativa strike (linha horizontal cortando)
#  
# Comandos de cores (3-bit, original):
#                 black red green yellow blue magenta cyan white
# Foreground:      30   31   32     33    34    35     36   37
# Bright fg:       90   91   92     93    94    95     96   97
# Background:      40   41   42     43    44    45     46   47
# Bright bg::     100   101  102    103   104   105    106  107
#
# Comandos de cores (8-bit, 256 cores):
#
# Foreground: 38;5;n onde n é um número de 0 a 255
# Background: 48;5;n onde n é um número de 0 a 255
#
# A regra das cores de 8 bits são:
#  0 a 7 são cores normais
#  8 a 15 são suas versões brilhantes
#  16 a 231 formam 216 cores no cubo 6x6x6 (fórmula: 16 + 36*R + 6*G + B, onde 0 <= R,G,B <= 5)
#  232 a 255 são tons de cinza em 24 passos do escuro ao claro
#
# Comandos de cores (24-bit, True Color, o mais moderno):
#
# Foreground: 38;2;r;g;b onde 0 <= r,g,b <= 255
# Foreground: 48;2;r;g;b onde 0 <= r,g,b <= 255
# 
# --------------------------------------------------------------
# PS1='\[\e[94M\][\u@\h \w]\[\e[0m\]\[\e[92;1m\]\n\$\[\e[0m\] '
#PS1='\[\e[96m\][\u@\h \w]\n\[\e[92m\]\$ \[\e[0m\]'
# Importante: para o PS1 interpretar subshell é necessário ser definido
# em aspas simples ou escapar o $ em aspas duplas
#PS1='\[\e[96m\][\u@\h \w] $(show_last_status)\n\[\e[92m\]\$ \[\e[0m\]'
# É importante que o \[  \] esteja fora da função, justificando abaixo...
#now_hour=$(date +'%H' | bc)
#if [[ $now_hour -ge 6 && $now_hour -lt 18 ]]; then
    #PS1='\[\e[96m\][\u@\h \w] \[$(show_last_status)\]\n\[\e[37m\]\$ \[\e[0m\]'
#else
    #PS1='\[\e[96m\][\u@\h \w] \[$(show_last_status)\]\n\[\e[92m\]\$ \[\e[0m\]'
#fi
PS1='\[\e[96m\][\u@\h \w] \[$(show_last_status)\]\n\[\e[92m\]\$ \[\e[0m\]'

# ---------------------------------
# Variáveis, exportações e sources
# ---------------------------------

# Instalacao das Funcoes ZZ (www.funcoeszz.net)
export ZZOFF=""  # desligue funcoes indesejadas
export ZZPATH="/usr/bin/funcoeszz"  # script
export ZZDIR=""    # pasta zz/
source "$ZZPATH"

PATH="$PATH:/opt/lampp/bin/:/home/saulo/.local/bin/"
export PATH

PATH="/home/saulo/.perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/saulo/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/saulo/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/saulo/.perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/saulo/.perl5"; export PERL_MM_OPT;

QT_QPA_PLATFORMTHEME=qt6ct; export QT_QPA_PLATFORMTHEME

# ---------------------------------
# Programas automáticos
# ---------------------------------

