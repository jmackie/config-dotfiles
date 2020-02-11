#!/usr/bin/env bash

__write_prompt() {
	local last_exit=$?

	local prompt_char
	if [[ -z "$IN_NIX_SHELL" ]]; then
		prompt_char="❯"
	else
		prompt_char="λ"
	fi

	local njobs
	njobs="$(jobs | wc -l)"

	# Pretty colour functions
	echo_colour() {
		local _end="\[\033[0m\]"
		echo -n -e "${1}${2}${_end}"
	}

	echo_white() { echo_colour "\[\033[0;37m\]" "$1"; }
	echo_red_bold() { echo_colour "\[\033[1;31m\]" "$1"; }
	echo_cyan_bold() { echo_colour "\[\033[1;36m\]" "$1"; }
	echo_green_bold() { echo_colour "\[\033[1;32m\]" "$1"; }
	echo_yellow_bold() { echo_colour "\[\033[1;33m\]" "$1"; }
	echo_gray_bold() { echo_colour "\[\033[1;30m\]" "$1"; }

	echo_host_colour() {
		# Colour for specific parts of the prompt, based on the hostname.
		# This is so I don't get confused when swapping/ssh'ing into
		# different machines.
		case $HOSTNAME in
		laptop)
			echo_green_bold "$1"
			;;
		habito)
			echo_cyan_bold "$1"
			;;
		*)
			echo_red_bold "$1"
			;;
		esac
	}

	fn_exists() {
		declare -f -F "$1" >/dev/null
		return $?
	}

	echo_host_colour "[${USER}@${HOSTNAME}] "

	echo_gray_bold "$(pwd | sed "s ${HOME} \~ ")"

	if fn_exists __git_ps1; then
		echo_yellow_bold "$(GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWUPSTREAM=1 GIT_PS1_SHOWCOLORHINTS=1 __git_ps1)"
	fi

	# newline
	echo

	if [[ "$njobs" -gt "0" ]]; then
		echo_gray_bold "($njobs) "
	fi

	# Display how many terminals deep we are
	INITIAL_SHLVL=4
	for ((n = INITIAL_SHLVL; n < SHLVL; n++)); do
		echo_white "$prompt_char"
	done

	# Toggle the colour of the final $prompt_char
	# based on the previous exit code
	case $last_exit in
	0 | 148)
		# NOTE: "148" is returned when a process is suspended (Ctrl+z)
		echo_host_colour "$prompt_char "
		;;
	*)
		echo_red_bold "$prompt_char "
		;;
	esac
}

__prompt() {
	PS1="$(__write_prompt)"
}

export PROMPT_COMMAND=__prompt

# fzf
# https://github.com/junegunn/fzf/wiki/examples
# fd - cd to selected directory
fd() {
	local dir
	dir="$(find "${1:-.}" -path '*/\.*' -prune \
		-o -type d -print 2>/dev/null | fzf +m)" &&
		cd "$dir" || return
}

# https://alpmestan.com/posts/2017-09-06-quick-haskell-hacking-with-nix.html
nix-haskell() {
	if [[ $# -lt 2 ]]; then
		echo "Must provide a ghc version (e.g ghc821) and at least one package"
		return 1
	else
		ghcver=$1
		pkgs=${*:2}
		echo "Starting haskell shell, ghc = $ghcver, pkgs = $pkgs"
		nix-shell -p "haskell.packages.$ghcver.ghcWithPackages (pkgs: with pkgs; [$pkgs])"
	fi
}

eval "$(direnv hook bash)"

if [ -f "$HOME/.fzf.bash" ]; then
	. "$HOME/.fzf.bash"
fi
