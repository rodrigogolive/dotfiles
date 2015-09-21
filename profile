# vim: set filetype=sh:

# super grep, will show grep on 'less' if result be greater than the console height
function sgrep(){
    result=$(grep -n --color=always --exclude=\*~ "$@" | sed 's/:/ +/')

    lines=$(echo "${result}" | wc -l)

    if (( $LINES <= $lines + 3 ))
    then
        echo "${result}" | less -R
    else
        echo "${result}"
    fi
}

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

# definicoes especificas por usuario
if [ "$USER" = rodrigo ]
then
    # ssh keys (and gpg) on keychain
    # add keys after '--quick'
    eval `keychain --eval --quiet --agents "ssh,gpg" --quick`

    # PATHs definition
    PATH="$HOME/.bin/:$PATH"
    PATH="$HOME/downloads/GIT/powerline/scripts:$PATH" # powerline

    # NOTE: must run 'python setup.py build' on powerline directory
    export POWERLINE_COMMAND="$HOME/downloads/GIT/powerline/client/powerline.sh"

    pdpid=$(pgrep -f powerline-daemon)
    if [ -z $pdpid ]
    then
        powerline-daemon -q&
    fi

    export PYTHONSTARTUP=$HOME/.pythonrc

    alias mplayer='mplayer -vo corevideo'
    alias qmlviewer='QML_IMPORT_TRACE=1 qmlviewer'

    # DROPCORE ;)
    export DROPCORE="$HOME/DockZ/DropCore"
    PATH="/opt/local/bin:/opt/local/sbin:$PATH"
    MANPATH="/opt/local/share/man:$MANPATH"
    PATH="/opt/local/libexec/gnubin/:$PATH"

    PATH="/usr/local/sbin/:$PATH"
    PATH="/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin:$PATH"
    PATH="/opt/Qt5.4.0/5.4/clang_64/bin/:$PATH"

    alias tig='TERM=screen-256color tig'
    alias weechat='TERM=screen-256color weechat'
    alias htop='TERM=screen-256color htop'

    alias ldd="otool -L"

    export DYLD_FALLBACK_LIBRARY_PATH="/opt/local/lib"
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"

    # mutt
    alias mutt-personal="mutt -e 'source ~/.mutt/accounts/personal'"
    alias mutt-work="mutt -e 'source ~/.mutt/accounts/work'"
fi

. ~/.extras/git-prompt.sh # symbolic link to the git repository completion script

# global definitions
stty -ixon

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export GREP_COLOR="03;33"

alias grep='grep -n --color=always --exclude=\*~'
alias less='less -R'

alias ls='ls --color=always'
alias nls='ls -1 | wc -l'
alias tls='ls -ot --color --ignore=\*~ | head | grep -v "total" | tr -s " " | cut -d" " -f5- | column -t'
alias als='ls -la'

alias bkpchrome='rm -rf ~/.config/chromium_BKP/; cp -r ~/.config/chromium{,_BKP}'
alias wget='wget -c'

alias cmake='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'
alias vless='/opt/local/share/vim/vim74/macros/less.sh'
alias make='bear -a make'

# simple bell, usefull when waiting the completion of something on another
# tmux window ;)
alias bell='echo -n "\007"' # or 'tput bel'

# global git exports; really they need to be empty values
export GIT_PS1_SHOWDIRTYSTATE=mdk
export GIT_PS1_SHOWSTASHSTATE=mdk
export GIT_PS1_SHOWUPSTREAM="auto"

export EDITOR="vim"
export GIT_EDITOR=$EDITOR
export SVN_EDITOR=$GIT_EDITOR

export TERM="xterm-256color"

export PYTHONSTARTUP=$HOME/.pythonrc

if [[ -n "$DISPLAY" && -z "$TMUX" ]];
then
    tmux
fi

eval $(dircolors ~/downloads/GIT/dircolors-solarized/dircolors.256dark)

# my own completions
source $HOME/.completions/*
