autoload -Uz compinit promptinit
compinit
promptinit

plugins=(git)
#Setup config file sync
alias cfg='/usr/bin/git --git-dir=$HOME/src/archconfig --work-tree=$HOME'


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

if [[ $TTY -eq 0 && POWERLINE -eq 1 ]]; then
    precmd_functions+=(prompt_powerline)
else
    precmd_functions+=(prompt_default)
fi 
