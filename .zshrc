#! /usr/bin/env bash

export PATH="${HOME}/.scripts:${HOME}/.local/bin:${HOME}/bin:${PATH}"

export HISTFILE="${HOME}/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

setopt NO_BEEP
setopt NO_CORRECT
setopt NO_CORRECT_ALL
setopt INTERACTIVE_COMMENTS

# Path to your Oh My Zsh installation.
export ZSH="${HOME}/.omz"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes for a list of themes.
export ZSH_THEME='terminalparty'

export CASE_SENSITIVE='false'

# Case-sensitive completion must be off.
# "_" and "-" will be interchangeable.
export HYPHEN_INSENSITIVE='true'

export ENABLE_CORRECTION='false'
export COMPLETION_WAITING_DOTS='true'
export HIST_STAMPS='yyyy-mm-dd'

# Uncomment the following line if pasting URLs and other text is messed up.
#
# export DISABLE_MAGIC_FUNCTIONS='true'

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
#
# export DISABLE_UNTRACKED_FILES_DIRTY='true'

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14
zstyle ':omz:update' cooldown 14

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source "${ZSH}/oh-my-zsh.sh"

export LANG='en_US.UTF-8'
export BROWSER='firefox'

# Preferred editor for local and remote sessions.
if [[ -n ${SSH_CONNECTION} ]]; then
    export EDITOR='nano'
else
    export EDITOR='nvim'
fi

alias reload='source "${HOME}/.zshrc"'

_command_exists() {
    command -v "$1" > /dev/null 2>&1
}

_command_exists yazi && alias y='yazi'
_command_exists yazi && alias yc='yazi "${HOME}/.config"'
_command_exists yazi && alias ys='yazi "${HOME}/.scripts"'

_command_exists bat && alias cat='bat --style full --theme ansi'

_command_exists eza && alias ls="eza \
    --almost-all \
    --group-directories-first \
    --long \
    --header \
    --git"

_command_exists shellcheck && alias sc="shellcheck \
    --enable all \
    --exclude SC1090,SC1091,SC2034 \
    --severity style"

export FZF_DEFAULT_OPTS=" \
    --color=bg:#141414,fg:#8c8c8c,hl:#e0c341 \
    --color=bg+:#3d3d3d,fg+:#d0d0d0,hl+:#e0c341 \
    --color=info:#5e5e5e,prompt:#e0c341,pointer:#e0c341 \
    --color=marker:#e0c341,spinner:#8c8c8c,header:#5e5e5e \
    --color=border:#3d3d3d,label:#8c8c8c,gutter:#141414 \
    --color=query:#d0d0d0,disabled:#5e5e5e,separator:#303030,scrollbar:#5e5e5e \
    --border=sharp \
    --prompt='> ' \
    --pointer='>' \
    --marker='+'"

source <(fzf --zsh) || true
eval "$(zoxide init zsh --cmd cd || true)"
