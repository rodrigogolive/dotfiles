export PATH="$HOME/.bin:$PATH"
export EDITOR="nvim"
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/downloads/GIT/oh-my-zsh

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# virtualenv + virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON=/opt/local/bin/python2.7
WORKON_HOME="~/.envs"
source /opt/local/bin/virtualenvwrapper.sh-2.7
export VIRTUALENVWRAPPER_VIRTUALENV=/opt/local/bin/virtualenv-2.7

# NOTE: do not forget to add fasd to your PATH
plugins=(vi-mode vundle colored-man fasd extract virtualenv virtualenvwrapper)

# zsh-completions | https://github.com/zsh-users/zsh-completions
fpath=($HOME/downloads/GIT/zsh-completions/src $fpath)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
source $HOME/.profile

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

    #git_status=$(echo $git_status | sed "s/*/ /")
    #git_status=$(echo $git_status | sed "s/>/ /")
    #git_status=$(echo $git_status | sed "s/</ /")
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

bindkey "^S" history-incremental-pattern-search-forward #control + s
bindkey -M vicmd '^r' history-incremental-pattern-search-backward

# use caps lock (ESC) to toggle insert/command mode
bindkey -M vicmd "^[" vi-insert
bindkey -M viins "^[" vi-cmd-mode

#damn delay
KEYTIMEOUT=1

# fzf | https://github.com/junegunn/fzf
# # TODO test if 'ag' is available
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='/usr/local/bin/ag -g ""'
export FZF_DEFAULT_OPTS="--no-256 \
    --no-mouse \
    --ansi \
    -0 -1 \
    --color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254 \
    --color info:254,prompt:37,spinner:108,pointer:235,marker:235"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '$HOME/.config/ranger/scope.sh {}' \
    --bind 'ctrl-t:toggle-preview'"

fzf-history-widget-accept() {
    fzf-history-widget
    zle accept-line
}
zle -N fzf-history-widget-accept
bindkey '^F' fzf-history-widget-accept # control-f

# TODO bindings should be done after setting all plugins
bindkey "^R" history-incremental-pattern-search-backward # control + r
