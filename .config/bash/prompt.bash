#!/usr/bin/env bash

# See comments in `completion/git-prompt.sh` for an explanation of these flags
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_HIDE_IF_PWD_IGNORED=1

__prompt() {
    local LAMBDA          # cooler than `$`
    LAMBDA='\[\xCE\xBB\]' # NOTE: needs escaping

    # Print two lambdas if we're running a shell within a shell
    if [[ -n "$IN_SUBSHELL" || -n "$IN_NIX_SHELL" || -n "$STACK_EXE" ]]; then
        #     ^^^ bash             ^^^ nix-shell         ^^^ stack exec bash
        echo "$(magenta_light_bold "$LAMBDA")$(cyan_light_bold "$LAMBDA")"
    else
        magenta_light_bold "$LAMBDA"
    fi
}

PROMPT_COMMAND='__git_ps1 "$(blue \\u@\\h) $(gray_bold [\\W])" " $(__prompt) "'
