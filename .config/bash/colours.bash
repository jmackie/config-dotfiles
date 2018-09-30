#!/usr/bin/env bash

__colour() {
    # ANSI codes need to be enclosed in `\[` and `\]` when
    # used with special bash variables PS0/1/2/4.
    # See https://stackoverflow.com/a/28938235 for a dope explanation
    echo -e "\\[\\e[$1\\]$2\\[\\e[0m\\]"
}

red() {
    __colour '0;31m' "$*"
}

red_bold() {
    __colour '1;31m' "$*"
}

red_light() {
    __colour '0;91m' "$*"
}

red_light_bold() {
    __colour '1;91m' "$*"
}

green() {
    __colour '0;32m' "$*"
}

green_bold() {
    __colour '1;32m' "$*"
}

green_light() {
    __colour '0;92m' "$*"
}

green_light_bold() {
    __colour '1;92m' "$*"
}

yellow() {
    __colour '0;33m' "$*"
}

yellow_bold() {
    __colour '1;33m' "$*"
}

yellow_light() {
    __colour '0;93m' "$*"
}

yellow_light_bold() {
    __colour '1;93m' "$*"
}

blue() {
    __colour '0;34m' "$*"
}

blue_bold() {
    __colour '1;34m' "$*"
}

blue_light() {
    __colour '0;94m' "$*"
}

blue_light_bold() {
    __colour '1;94m' "$*"
}

magenta() {
    __colour '0;35m' "$*"
}

magenta_bold() {
    __colour '1;35m' "$*"
}

magenta_light() {
    __colour '0;95m' "$*"
}

magenta_light_bold() {
    __colour '1;95m' "$*"
}

cyan() {
    __colour '0;36m' "$*"
}

cyan_bold() {
    __colour '1;36m' "$*"
}

cyan_light() {
    __colour '0;96m' "$*"
}

cyan_light_bold() {
    __colour '1;96m' "$*"
}

gray() {
    __colour '0;90m' "$*"
}

gray_bold() {
    __colour '1;90m' "$*"
}

gray_light() {
    __colour '0;37m' "$*"
}

gray_light_bold() {
    __colour '1;37m' "$*"
}
