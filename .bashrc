#!/usr/bin/env bash

export TERM=xterm-256color
export PAGER='less -S -# 1'

export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" " $(((SHLVL > 3)) && echo $((SHLVL - 3)))\$ "'
#                                                  ^^ display terminal depth (our baseline is 3 because reasons)

alias rm='rm -vi'
alias grep='grep --color'
alias ll='ls -lAhF --color=auto'
alias wifi='nmcli device wifi'
alias vim='nvim'
alias cat="bat"
alias myip='curl http://ipecho.net/plain; echo'
alias randpass='openssl rand -base64 20'
alias yank='xclip -selection clipboard'

# fzf
# https://github.com/junegunn/fzf/wiki/examples
# fd - cd to selected directory
fd() {
	local dir
	dir="$(find "${1:-.}" -path '*/\.*' -prune \
		-o -type d -print 2>/dev/null | fzf +m)" \
		&& cd "$dir" || return
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
