#!/usr/bin/env bash
# shellcheck source=/dev/null

if [ -f "$HOME/.config/bash/init.bash" ]; then
    source "$HOME/.config/bash/init.bash"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
