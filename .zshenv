#if [ -n "$DESKTOP_SESSION" ]; then
#	eval $(gnome-keyring-daemon --start)
#	export SSH_AUTH_SOCK
#fi

if [ -e "$HOME/.cargo/bin" ]; then
	PATH="$HOME/.cargo/bin:$PATH"
fi
if [ -e "$HOME/.local/bin" ]; then
	PATH="$HOME/.local/bin:$PATH"
fi

export EDITOR=nvim
alias vim=nvim
alias vi=vim
alias hc=herbstclient
alias irssi="irssi --home=~/.config/irssi"
if [ -e "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi
