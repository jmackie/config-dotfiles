#!/usr/bin/env bash

# Trim lines and join with ' '
__collapse() {
    echo "$1" | sed 's/^ *//;s/ *$//' | tr '\n' ' '
}

# Usage:
# $ hashell aeson HTTP
hashell() {
    local PACKAGES
    PACKAGES=$(
        cat <<END
    (haskell.packages.ghc842.override {
        overrides = (self: super: {
            ghc = super.ghc // { withPackages = super.ghc.withHoogle; };
            ghcWithPackages = self.ghc.withPackages;
        });
    }).ghcWithPackages(pkgs: with pkgs; [ $@ ])
END
    )
    nix-shell -p "$(__collapse "$PACKAGES")"
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
