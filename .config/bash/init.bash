#!/usr/bin/env bash
# shellcheck source=/dev/null

__init() {
    local HERE
    HERE="$(dirname "${BASH_SOURCE[0]}")"

    # NOTE: order is important
    for FILE in "$HERE"/completion/*; do
        source "$FILE"
    done
    source "$HERE/env.bash"
    source "$HERE/colours.bash"
    source "$HERE/functions.bash"
    source "$HERE/prompt.bash"
    source "$HERE/aliases.bash"
    source "$HERE/secret.bash" # NOTE: not in source control

    # Fire up tmux (if possible)
    #if command -v tmux >/dev/null; then
    #	[[ ! "$TERM" =~ screen ]] && [ -z "$TMUX" ] && exec tmux
    #fi

    eval "$(direnv hook bash)"
}

__init
