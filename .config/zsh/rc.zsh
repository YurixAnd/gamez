#!/bin/sh
#vim: ft=zsh

# Выбор цветовой палитры терминала
if [[ $TERM == "linux" ]]
then
    TERM="linux"
else
    TERM="xterm-256color"
fi

# Выход из сеанса суперпользователя через 60 секунд бездействия
if [[ $UID == "0" ]]
then
    TMOUT=60
fi

# Стандартные переменные
ZDOTDIR=$HOME/.config/zsh # Пусть будет
export PATH="$PATH:$HOME/.local/bin" # Локальные скрипты и бинарники
export BROWSER="firefox-bin"

# История
HISTFILE=~/.cache/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000
export HISTTIMEFORMAT="%t.%d.%m.%y %H:%M:%S%t"
export HISTIGNORE="&:ls:[bf]g:exit"
setopt APPEND_HISTORY
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_NO_STORE
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# Опции
setopt IGNORE_EOF # Не считать Control+C за выход из оболочки 
setopt AUTO_CD # Если набрали путь к директории без комманды CD, то перейти 
setopt CORRECT_ALL # Исправлять неверно набранные комманды 
SPROMPT='zsh: Заменить '\''%R'\'' на '\''%r'\'' ? [Yes/No/Abort/Edit]' # Строка замены
setopt SH_WORD_SPLIT # zsh будет обращаться с пробелами так же, как и bash 
setopt BRACE_CCL # Разворачивание выражений типа {1 - 3} в 1 2 3
setopt NO_BEEP # Не пищать
setopt EXTENDED_GLOB # Расширенные шаблоны
setopt NO_NOMATCH # Не выводить 'zsh: no matches found...'
setopt NOTIFY # Немедленный отчет о статусе фоновых заданий
setopt NO_HUP # Не посылать HUP сигнал выполняемым задания при выходе из шелла
setopt CHECK_JOBS # Отчет о статусе выполняемы фоновых заданий при выходе из шелла
setopt LONG_LIST_JOBS # Расширенный формат списка выполняемых заданий
setopt HASH_LIST_ALL # Хешировать пути при автодополнении
setopt COMPLETE_IN_WORD # Установка курсора в конце слова при автодополнеии
setopt PUSHD_TO_HOME # pushd без аргументов действует как pushd $HOME
setopt PUSHD_SILENT # Тихий режим работы pushd и popd
setopt PUSHD_MINUS # Использование "+" и "-" при указании номера директории в стеке
setopt CDABLE_VARS # Если аргумент для команды cd не является каталогом попытаться расширить выражение
setopt AUTO_RESUME # Простые команды не возобнявляют выполняемыш фоновые задания 
setopt NO_CLOBBER # Использовать вместо > или >> перенаправления в стиле >| и >>|
setopt AUTO_PUSHD # Команда cd переносит старую папку в стек директорий
setopt RC_QUOTES # Использовать одинарные кавычки (') для выделения выражений
setopt MAIL_WARNING # Выдать предупреждение если mail файл был изменен после последней проверки
unsetopt BG_NICE # Запускать фоновые задания с пониженным приоритетом
unsetopt AUTO_PARAM_SLASH # Автомотическое добаление слеша к имени каталогов

typeset -U path cdpath fpath manpath # Автоматическое удаление повторов из массива

# Настройка клавиш
: << Comment
[[ -n ${key[Home]}      ]]  && bindkey  "${key[Home]}"      beginning-of-line
[[ -n ${key[End]}       ]]  && bindkey  "${key[End]}"       end-of-line
[[ -n ${key[Insert]}    ]]  && bindkey  "${key[Insert]}"    overwrite-mode
[[ -n ${key[Delete]}    ]]  && bindkey  "${key[Delete]}"    delete-char
[[ -n ${key[PageUp]}    ]]  && bindkey  "${key[PageUp]}"    up-line-or-history
[[ -n ${key[PageDown]}  ]]  && bindkey  "${key[PageDown]}"  down-line-or-history
[[ -n ${key[Left]}      ]]  && bindkey  "${key[Left]}"      backward-char
[[ -n ${key[Right]}     ]]  && bindkey  "${key[Right]}"     forward-char
[[ -n ${key[Up]}        ]]  && bindkey  "${key[Up]}"        history-beginning-search-backward-end
[[ -n ${key[Down]}      ]]  && bindkey  "${key[Down]}"      history-beginning-search-forward-end
[[ -n ${key[Backspace]} ]]  && bindkey  "${key[Backspace]}" backward-delete-char
Comment

case $TERM in
    linux)
#        bindkey "^[[2~" yank
        bindkey "^[[3~" delete-char
        bindkey "^[[5~" up-line-or-history
        bindkey "^[[6~" down-line-or-history
        bindkey "^[[H"  beginning-of-line
        bindkey "^[[F"  end-of-line
        bindkey "^E"    expand-cmd-path # C-e for expanding path of typed command
        bindkey "^[OA"  history-beginning-search-backward-end # up arrow for back-history-search
        bindkey "^[OB"  history-beginning-search-forward-end # down arrow for fwd-history-search
        bindkey " "     magic-space;; # do history expansion on space
    *xterm*|*rxvt*|(dt|k|E)term)
#        bindkey "^[[2~" yank
        bindkey "^[[3~" delete-char
        bindkey "^[[5~" up-line-or-history
        bindkey "^[[6~" down-line-or-history
        bindkey "^[[H"  beginning-of-line
        bindkey "^[[F"  end-of-line
        bindkey "^E"    expand-cmd-path ## C-e for expanding path of typed command
        bindkey "^[OA"  history-beginning-search-backward-end # up arrow for back-history-search
        bindkey "^[OB"  history-beginning-search-forward-end # down arrow for fwd-history-search
        bindkey " "     magic-space;; ## do history expansion on space
esac
