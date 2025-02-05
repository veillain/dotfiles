# ~/.bashrc


# ---- Environments ----
export PATH=$HOME/bin:$HOME/.config/bin:/usr/local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="google-chrome-stable"
export VISUAL="${EDITOR}"
export WLR_NO_HARDWARE_CURSORS=1
# Evals
eval "$(starship init bash)"
eval "$(zoxide init bash)"


# ---- Settings ----
[[ $- != *i* ]] && return
HISTSIZE=5000
HISTFILE=$HOME/.config/bashist
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups


# ---- Alias ----
alias cd='z'
alias ls='eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions -la'
alias grep='grep --color=auto'
alias vi='nvim'
alias neovim='nvim'
alias bf='clear; bunnyfetch'
alias df='df -h'
alias free='free -h'
alias boottime='systemd-analyze'
alias grep='grep --color=auto'
alias init.lua='nvim $HOME/.config/nvim/init.lua'
PS1='[\u@\h \W]\$ '

bunnyfetch
