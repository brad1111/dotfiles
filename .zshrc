autoload -Uz compinit promptinit
compinit
promptinit

plugins=(git)
#Setup config file sync
alias cfg='/usr/bin/git --git-dir=$HOME/src/dotfiles --work-tree=$HOME'


#setup powerline
prompt_powerline() {
	PS1="$(powerline-rs --shell zsh --modules user,host,ssh,cwd,perms,git,gitstage,nix-shell,root $?)"
}

prompt_default() {
	PS1="%F{green}$(whoami)@$(hostname)%F{white}:%F{cyan}%~%F{white}$ "
}
if [[ $(tty | grep tty) == "" ]]; then
    TTY=0
else
    TTY=1
fi
which powerline-rs &> /dev/null
if [[ $? -eq 0 ]]; then
    POWERLINE=1
else
    POWERLINE=0
fi

if [[ $WSLENV != "" ]]; then
    WSL=1
else
    WSL=0
fi

if [[ ($TTY -eq 0 || $WSL -eq 1)  && POWERLINE -eq 1 ]]; then
    precmd_functions+=(prompt_powerline)
else
    precmd_functions+=(prompt_default)
fi 

# History
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups

# Vim bindings
bindkey -v
