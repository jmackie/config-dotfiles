#!/usr/bin/env bash
#
# Executed by `startx`

# https://wiki.archlinux.org/index.php/X_resources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration#Using_xset
# xset r rate delay [rate]
xset r rate 300 30

# Machine specific initialization
case $HOSTNAME in
habito)
	[[ -f ~/.screenlayout/default.sh ]] && ~/.screenlayout/default.sh
	;;
esac

exec xmonad
