#!/bin/sh
# vim: filetype=zsh


precmd() {
    [[ -t 1  ]] || return
    case $TERM in
        *xterm*|*rxvt*|(dt|k|E|a)term*) print -Pn "\e]0;[%~] %m\a";;
        screen(-bce|.linux)) print -Pn "\ek[%~]\e" && print -Pn "\e]0;[%~] %m (scree   n)\a";;
    esac
}

preexec() {
    [[ -t 1  ]] || return
    case $TERM in
        *xterm*|*rxvt*|(dt|k|E|a)term*) print -Pn "\e]0;<$1> [%~] %m\a";;
        screen(-bce|.linux)) print -Pn "\ek<$1> [%~]\e" && print -Pn "\e]0;<$1> [%~]    %m (screen)\a" ;;
    esac
}
typeset -g -A key
