#!/bin/sh
#vim: filetype=zsh

autoload -U colors promptinit
colors
promptinit
prompt sorin

eval "$(dircolors ~/.dir_colors)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# LESS
export LESS_TERMCAP_mb=$'\E[01;31m'       # начала мигающего
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # начало жирного текста
export LESS_TERMCAP_me=$'\E[0m'           # окончание
export LESS_TERMCAP_so=$'\E[38;5;246m'    # начала текста в инфобоксе
export LESS_TERMCAP_se=$'\E[0m'           # конец его
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # начало подчеркнутого
export LESS_TERMCAP_ue=$'\E[0m'           # конец подчеркнутого

alias -g  HE='2>>( sed -ue "s/.*/$fg[red]&$reset_color/" 1>&2  )' #Поток ошибок красным цветом
