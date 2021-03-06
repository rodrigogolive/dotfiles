# vim: set filetype=sh:

# super run, will copy to the clipboard a given command as an argument or the last runned command, if no arguments
function srun(){
    if [[ x$@ !=  x ]]
    then
        echo $@ | xclip
    else
        result=$(history | tail -n2 | head -n1 | sed 's/   */_/g' | cut -d'_' -f3-)
        echo $result | xclip
    fi
}

# super cd, will save the last directory that you gone. Passing just xcd will entry on the mentioned dir. Util only with no new data has been sento to the clipboard buffer
function scd(){
    if [ x$@ == x ]
    then
        dir=$(xclip -o)

        if [ -d $dir ]
        then
            cd $dir
        else
            echo "scd: \"$dir\" isn't a valid directory"
        fi
    else
        cd $@
        pwd | xclip
    fi
}

# super pwd, will put the working dir path on the clipboard buffer
function spwd(){
    pwd | xclip
}

# recursively remove temp (backup) files
function erase_bkp(){
    recursive=0

    while [ $# -gt 0 ]
    do
        case $1 in
            -r)
                recursive=1
                shift 1
                ;;
            *)
                echo "Invalid argument $1"
                shift 1
                ;;
        esac
    done

    if [[ $recursive = 1 ]]
    then
        find . -iname \*~ | xargs rm
    else
        find . -iname \*~ -maxdepth 1 | xargs rm
    fi
}

# git please <REMOTE>
_git_please() {
    __git_remotes
}

# gpg/ssh
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$  ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
if [ -x "$(which gpg-connect-agent)"  ]; then
    gpg-connect-agent updatestartuptty /bye >& /dev/null
fi
export PINENTRY_USER_DATA="USE_CURSES=1"

# PATHs definition
PATH="$HOME/.bin:$PATH"
PATH="/sbin:/usr/sbin:$PATH"

# DROPCORE ;)
export DROPCORE="$HOME/DockZ/DropCore"

. ~/.extras/git-prompt.sh # symbolic link to the git repository completion script

# global definitions
stty -ixon

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

alias grep='grep -n --color=auto --exclude=\*~'
alias less='less -R'
alias ip='ip --color=auto'

alias ls='ls --color=auto'
alias nls='ls -1 | wc -l'
alias tls='ls -ot --color --ignore=\*~ | head | grep -v "total" | tr -s " " | cut -d" " -f5- | column -t'
alias als='ls -la'

alias wget='wget -c'

alias cmake='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
alias make='bear -a make'

alias diff='diff --color=auto'

# simple bell, usefull when waiting the completion of something on another
# tmux window ;)
alias bell='echo -n "\007"' # or 'tput bel'

# global git exports; really they need to be empty values
export GIT_PS1_SHOWDIRTYSTATE=mdk
export GIT_PS1_SHOWSTASHSTATE=mdk
export GIT_PS1_SHOWUPSTREAM="auto"

export EDITOR="nvim"
export GIT_EDITOR=$EDITOR
export SVN_EDITOR=$GIT_EDITOR

export PYTHONSTARTUP=$HOME/.pythonrc

if [[ -n "$DISPLAY" && -z "$TMUX" ]];
then
    tmux
fi

# my own completions
source $HOME/.completions/*

# pass
export PASSWORD_STORE_DIR=$HOME/DockZ/ownButt/password-store
export PASSWORD_STORE_GIT=$PASSWORD_STORE_DIR

# use clang as c/c++ compiler as default
export CC=clang
export CXX=clang++
