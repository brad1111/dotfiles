if [ -n "$DESKTOP_SESSION" ]; then
	eval $(gnome-keyring-daemon --start)
	export SSH_AUTH_SOCK
fi

export EDITOR=nvim
alias vim=nvim
alias vi=vim
