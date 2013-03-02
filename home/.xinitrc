#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Export environment variables:
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export EDITOR="/usr/bin/nano"

# Set keyboard layout:
setxkbmap gb dvorak

# Run AwesomeWM
exec awesome >> $HOME/.cache/awesome/stdout
