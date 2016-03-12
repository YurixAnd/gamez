#!/bin/sh
# vim ft=zsh

# Конфиги zsh
ZDOTDIR=$HOME/.config/zsh

# Загрузка zprezto
source $ZDOTDIR/.zprezto/init.zsh

# Загрузка пользовательских конфигов
for rc in $ZDOTDIR/*.zsh
do
    source $rc
done
unset rc
