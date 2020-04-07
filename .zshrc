plugins=(git)
#Setup config file sync
alias cfg='/usr/bin/git --git-dir=$HOME/src/archconfig --work-tree=$HOME'

prompt() {
	PS1="$(powerline-rs --shell zsh --modules user,host,ssh,cwd,perms,git,gitstage,nix-shell,root $?)"
}
precmd_functions+=(prompt)
