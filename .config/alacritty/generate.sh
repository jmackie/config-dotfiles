#! /usr/bin/env nix-shell
#! nix-shell -i bash -p curl yq-go

set -euo pipefail
set -x

ALACRITTY_VERSION=$(alacritty --version | awk '{ print $2 }')

curl -L "https://github.com/alacritty/alacritty/releases/download/v${ALACRITTY_VERSION}/alacritty.yml" > default.yml

# https://github.com/mikefarah/yq/issues/201
PATCHED=$(mktemp --suffix=.yml)
sed 's/\by\b/"y"/g' default.yml > "${PATCHED}"

yq merge -x "${PATCHED}" overrides.yml > alacritty.yml
