#!/usr/bin/env bash

CDPATH="$HOME:$CDPATH"
TERM=xterm-256color

JAVA_HOME="$(readlink -e "$(type -p javac)" | sed -e 's/\/bin\/javac//g')"
export JAVA_HOME
