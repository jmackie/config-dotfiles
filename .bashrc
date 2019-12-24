#!/usr/bin/env bash

export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" " $(((SHLVL > 3)) && echo $((SHLVL - 3)))\$ "'
#                                                  ^^ display terminal depth (our baseline is 3 because reasons)

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
