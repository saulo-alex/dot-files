#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '
PS1='\[\e[;32m\]\u\[\e[0m\] \[\e[;35m\][\w]\[\e[0m\] \[\e[;32m\]$ \[\e[0m\]'

# Instalacao das Funcoes ZZ (www.funcoeszz.net)
export ZZOFF=""  # desligue funcoes indesejadas
export ZZPATH="/usr/bin/funcoeszz"  # script
source "$ZZPATH"

PATH="/home/saulo/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/saulo/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/saulo/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/saulo/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/saulo/perl5"; export PERL_MM_OPT;
