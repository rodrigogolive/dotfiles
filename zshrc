export PATH="$HOME/.bin:$PATH"
# pip things
export PATH="$HOME/.local/bin:$PATH"

export EDITOR="nvim"
# Path to your oh-my-zsh configuration.
export ZSH=$HOME/downloads/GIT/oh-my-zsh

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
VIRTUAL_ENV_DISABLE_PROMPT="true"

# NOTE: do not forget to add fasd to your PATH
#plugins=(vi-mode vundle fasd extract colored-man-pages pyenv pipenv vagrant)
plugins=(vi-mode vundle fasd extract colored-man-pages pyenv pipenv vagrant npm)

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

# powerlevel9k; only if on X
if [ -n "$DISPLAY" ]
then
    # set powerlevel9k mode
    POWERLEVEL9K_MODE='nerdfont-complete'

    # prompt configuration
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir dir_writable)
    # ip os_icon ssh pyenv? TODO
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs pyenv virtualenv
        vcs vi_mode)
    #POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs pyenv vcs vi_mode)

    # context segment TODO
    DEFAULT_USER=$USER
    POWERLEVEL9K_ALWAYS_SHOW_USER=true

    # dir segment
    POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
    POWERLEVEL9K_SHORTEN_DELIMITER=""
    POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

    # status segment
    POWERLEVEL9K_STATUS_OK=false

    # vcs segment
    POWERLEVEL9K_SHOW_CHANGESET=true

    source $HOME/downloads/GIT/powerlevel9k/powerlevel9k.zsh-theme
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
export FZF_DEFAULT_OPTS="--no-mouse \
    --ansi \
    -0 -1 \
    --color=bg+:18,bg:0,spinner:6,hl:4 \
    --color=fg:20,header:4,info:3,pointer:6 \
    --color=marker:6,fg+:21,prompt:3,hl+:4"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '$HOME/.config/ranger/scope.sh {} \
        $(tput cols) $(tput lines) $HOME/.cache/ranger False' \
    --bind 'ctrl-t:toggle-preview'"

# based on https://github.com/junegunn/fzf/issues/477#issuecomment-444053054
fzf-history-widget-accept-or-edit() {
    local selected num
    setopt localoptions noglobsubst noposixbuiltins pipefail 2> /dev/null
    selected=( $(fc -rl 1 |
        FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS \
        -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort --expect=ctrl-e \
        $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd))
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

# Base16 Shell
BASE16_SHELL="$HOME/downloads/GIT/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
