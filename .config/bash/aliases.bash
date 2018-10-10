#!/usr/bin/env bash

# Register when we're in a subshell for prompt
alias bash='IN_SUBSHELL=1 bash'

# Make some of the file manipulation programs verbose alias mv='mv -v'
alias rm='rm -vi'
alias cp='cp -v'

# grep modifications
alias grep='grep --color'
alias grepp='grep -P --color'

# Shell helpers, some stolen from:
# https://www.digitalocean.com/community/tutorials/an-introduction-to-useful-bash-aliases-and-functions
alias ls='ls -CF'
alias ll='ls -lAhF --color=auto'
alias fhere='find . -name'
alias ps='ps auxf'
alias mkdir='mkdir -pv'
alias wget='wget -c'
alias top='htop'
alias myip='curl http://ipecho.net/plain; echo'
alias webify='mogrify -resize 690\> *.png'
alias now='date --iso-8601=seconds'
alias now_utc="TZ='UTC' date --iso-8601=seconds"

# Generate a random password
alias randpass='openssl rand -base64 20'

# Check wifi status easily
alias wifi='nmcli device wifi'

# Neovim ftw
alias vim='nvim'

# https://github.com/github/hub
#eval "$(hub alias -s)"

# Character encoding hack; I don't really know why this is necessary...
alias ghci="LC_ALL= ghci"
