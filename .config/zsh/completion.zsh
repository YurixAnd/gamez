#!/bin/sh
# vim: filetype=zsh

autoload -U compinit edit-command-line url-quote-magic history-beginning-search-backward-end history-search-end history-beginning-search-forward-end history-search-end
compinit
zle -N edit-command-line
zle -N self-insert url-quote-magic
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

setopt AUTO_LIST
setopt AUTO_MENU

zstyle ':completion:*' rehash true
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.cache/zsh/zcache
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

#Completion Options
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _ignored _prefix _correct _prefix _match _approximate

# Path Expansion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Автодополнение для kill\killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:processes' command 'ps -au$USER'

# Group matches and Describe
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[00;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[00;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[00;31m -- No Matches Found --\e[0m'
