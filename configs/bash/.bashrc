# ~/.bashrc

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompr & Run
bunnyfetch
PS1='[\u@\h \W]\$ '

# Variables
eval "$(starship init bash)"
eval "$(zoxide init bash)"
export EDITOR="nvim"
export TERMINAL="foot"
export BROWSER="google-chrome-dev"
export VISUAL="${EDITOR}"

# Alias
alias clean='reset'
alias ff='clear; bunnyfetch'
alias ffl='while true; do bunnyfetch; sleep 3; clear; done'
alias fastfetch='clear; fastfetch'
alias ls='eza --color=always --git --no-filesize --icons=always --no-time --no-user --no-permissions -a'
alias grep='grep --color=auto'
alias df='df -h'
alias free='free -h'
alias cd='z'
alias tt='ttyper'
alias boottime='systemd-analyze'
alias shark='display3d $HOME/3d/shark/blahaj.obj'

# History
HISTFILE=~/.bashist
HISTSIZE=2000
SAVEHIST=2000

fileman(){
    rn=$(pwd)
    choice="$rn/$1"
    cd $choice
    nvim $choice +Oil
}
alias fm=fileman

# Github Upload
gitups(){
    previouscommitmsg=$(git log -1 | head -n 5 | tail -n 1 | sed 's/^    //')
    answer=$1
    git add $answer &&
    echo ""
    echo "Previous Commit: $previouscommitmsg"
    echo -n "commit message: "
    read message
    git commit -m "$message" &&
    git push -u origin main
}
alias gitup=gitups

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
alias yazi=y
