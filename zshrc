# Path to your oh-my-zsh configuration.
export ZSH=$HOME/downloads/GIT/oh-my-zsh

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# virtualenv + virtualenvwrapper | XXX not using at home right now, remove?
#VIRTUALENVWRAPPER_PYTHON=/opt/local/bin/python2.7
#WORKON_HOME="~/.envs"
#source /opt/local/bin/virtualenvwrapper.sh-2.7
#export VIRTUALENVWRAPPER_VIRTUALENV=/opt/local/bin/virtualenv-2.7

plugins=(vi-mode vundle colored-man)
#plugins=(vi-mode vundle colored-man virtualenv virtualenvwrapper)

# zsh-completions | https://github.com/zsh-users/zsh-completions
fpath=($HOME/downloads/GIT/zsh-completions/src $fpath)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
source $HOME/.profile

# z | https://github.com/rupa/z
#source $HOME/downloads/GIT/z/z.sh
# fasd | https://github.com/clvv/fasd/
# NOTE: do not forget to add fasd to your PATH
eval "$(fasd --init auto)"
# s | https://github.com/haosdent/s
source $HOME/downloads/GIT/s/s.sh

# XXX start using a zsh plugin manager (oh-my-zsh has so many old plugins)
# git-flow-completion | https://github.com/petervanderdoes/git-flow-completion
source $HOME/downloads/GIT/git-flow-completion/git-flow-completion.zsh

source $HOME/downloads/GIT/zce.zsh/zce.zsh
bindkey -M vicmd "f" zce
zstyle ':zce:*' bg 'fg=242'

# poweline
if [ -n "$DISPLAY" ]
then
    source $HOME/downloads/GIT/powerline/powerline/bindings/zsh/powerline.zsh
fi

# hide commands from history that starts with a space
export HIST_IGNORE_SPACE=1

# prompt :D
function _gitPrompt() {
    git_status=$(__git_ps1 "%s")

    git_status=$(echo $git_status | sed "s/*/ /")
    git_status=$(echo $git_status | sed "s/>/ /")
    git_status=$(echo $git_status | sed "s/</ /")
    # TODO =

    if [[ -n $git_status ]]
    then
        export GITPROMPT="$git_status"
    else
        unset GITPROMPT
    fi
}
precmd_functions+=(_gitPrompt)

# use same colors from dircolors on complete
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}


# key bindings (we need to re-enter them because vi-mode overwrite them)
bindkey "^[[1;5C" forward-word # control + left arrow
bindkey "^[[1;5D" backward-word # control + right arrow
bindkey "^F" forward-word # control + f
bindkey "^B" backward-word # control + b

bindkey '^[[Z' reverse-menu-complete # shift + tab

bindkey "^R" history-incremental-pattern-search-backward # control + r
bindkey "^S" history-incremental-pattern-search-forward #control + s

# use caps lock (ESC) to toggle insert/command mode
bindkey -M vicmd "^[" vi-insert
bindkey -M viins "^[" vi-cmd-mode

#damn delay
KEYTIMEOUT=1
