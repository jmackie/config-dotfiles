# NOTE: need to source .bashrc for ssh and tmux et al.

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
    # shellcheck disable=SC1090
		. "$HOME/.bashrc"
	fi
fi

# if not in an ssh 
if [ -z "$SSH_CLIENT" ] || [ -z "$SSH_TTY" ]; then
  # if X isn't already running then startx on login
  pidof X >/dev/null || startx
fi
