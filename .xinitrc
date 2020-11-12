#!/usr/bin/env bash
#
# Executed by `startx`

# https://wiki.archlinux.org/index.php/X_resources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Import $DISPLAY for systemd services
# (otherwise dunst.service fails to start, and probably fixes other things)
# https://github.com/dunst-project/dunst/issues/347#issuecomment-319370556
systemctl --user import-environment DISPLAY

# Start some services
systemctl --user start dunst redshift

# https://wiki.archlinux.org/index.php/Xorg/Keyboard_configuration#Using_xset
# xset r rate delay [rate]
xset r rate 300 30

# Dim the screen a bit
xrandr --output eDP-1 --brightness 0.7

# Machine specific initialization
case $HOSTNAME in
cerebro)
	[[ -f ~/.screenlayout/default.sh ]] && ~/.screenlayout/default.sh
	;;
esac

exec xmonad
