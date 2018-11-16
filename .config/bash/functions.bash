#!/usr/bin/env bash

# Trim lines and join with ' '
__collapse() {
    echo "$1" | sed 's/^ *//;s/ *$//' | tr '\n' ' '
}

nix-clean() {
    nix-env --delete-generations old
    nix-collect-garbage
    nix-collect-garbage -d
    nix-store --gc --print-dead
}

bak() {
    mv "$1" "$1.bak"
}

mkcd() {
    dir="$*"
    mkdir -p "$dir" && cd "$dir" || exit
}

# Credit:
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
