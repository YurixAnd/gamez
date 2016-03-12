#!/bin/sh
# vim: ft=zsh

# Отключение zsh коррекции
alias sudo='nocorrect sudo'
alias cp='nocorrect cp --interactive --recursive --verbose'
alias mv='nocorrect mv --interactive --verbose'
alias rm='nocorrect rm --interactive=once --recursive --verbose'
alias emerge='nocorrect emerge'
alias equery='nocorrect equery'
alias eix='nocorrect eix'
alias mkdir='nocorrect mkdir'
alias git='nocorrect git'

# Общее
alias df='pydf --human-readable'
alias du='du --human-readable --total'
alias nohup='nohup > /dev/null $1'
alias fuser='fuser --all --user --verbose'
alias free='free --human'
alias jobs='jobs -l'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias grep='grep --colour=auto'
alias ls='ls --color=auto --human-readable --classify --group-directories-first'


# Алиасы с su/sudo
alias svim='sudo vim'
alias sless='sudo less'

# Автодополнение алиасов
setopt completealiases
