export PATH="$HOME/.bin:$PATH"
# pip things
export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/downloads/GIT/oh-my-zsh

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# NOTE: do not forget to add fasd to your PATH
plugins=(vi-mode vundle fasd extract colored-man-pages virtualenv virtualenvwrapper)

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
export FZF_DEFAULT_COMMAND='/usr/bin/ag -g ""'
export FZF_DEFAULT_OPTS="--no-256 \
    --no-mouse \
    --ansi \
    -0 -1 \
    --color dark,hl:33,hl+:37,fg+:235,bg+:136,fg+:254 \
    --color info:254,prompt:37,spinner:108,pointer:235,marker:235"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '$HOME/.config/ranger/scope.sh {}' \
    --bind 'ctrl-t:toggle-preview'"

# based on https://github.com/junegunn/fzf/issues/477#issuecomment-444053054
fzf-history-widget-accept-or-edit() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
    selected=( $(fc -rl 1 |
        FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort --expect=ctrl-e $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd))
    )

    local ret=$?
    if [ -n "$selected" ]; then
        local accept=0
        if [[ $selected[1] = ctrl-e ]]; then
            accept=1
            shift selected
        fi

        num=$selected[1]
        if [ -n "$num" ]; then
            zle vi-fetch-history -n $num
            [[ $accept = 0 ]] && zle accept-line
        fi
    fi

    zle reset-prompt
    return $ret
}
zle -N fzf-history-widget-accept-or-edit
# control-f; enter run directly, control-e edit command
bindkey '^F' fzf-history-widget-accept-or-edit

# TODO bindings should be done after setting all plugins
# control + r
bindkey "^R" history-incremental-pattern-search-backward
