#! /usr/bin/env bash

export PATH="${HOME}/.scripts:${HOME}/.local/bin:${HOME}/bin:${PATH}"

HISTFILE="${HOME}/.zhistory"
HISTSIZE=10000
SAVEHIST=10000

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
ZSH_THEME="terminalparty"

CASE_SENSITIVE="false"

# Case-sensitive completion must be off.
# "_" and "-" will be interchangeable.
HYPHEN_INSENSITIVE="true"

ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Uncomment the following line if pasting URLs and other text is messed up.
#
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
#
# DISABLE_UNTRACKED_FILES_DIRTY="true"

zstyle ":omz:update" mode reminder
zstyle ":omz:update" frequency 14
zstyle ":omz:update" cooldown 14

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source "${ZSH}/oh-my-zsh.sh"

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions.
if [[ -n ${SSH_CONNECTION} ]]; then
    export EDITOR="nano"
else
    export EDITOR="nvim"
fi

alias reload='source "${HOME}/.zshrc"'

_command_exists() {
    command -v "$1" > /dev/null 2>&1
}

_command_exists yazi && alias y="yazi"
_command_exists yazi && alias yc='yazi "${HOME}/.config"'
_command_exists yazi && alias ys='yazi "${HOME}/.scripts"'

_command_exists bat && alias cat="bat --style full --theme ansi"

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

source <(fzf --zsh) || true

eval "$(zoxide init zsh --cmd cd || true)"
