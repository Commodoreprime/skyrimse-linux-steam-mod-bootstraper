#!/bin/bash
# Basic launcher to launch Skyrim but ask to load mods first
# to install, move script to Skyrim's game folder
# then modifiy the launch options in steam to run before the game
#   Something similar to this:
# ./start.sh "%command%"
# any enviroment variables or other wrapper commands go inside the quotes as well
#

BOOTSTRAPPED=false

zenity --width=120 --question --text="Bootstrap mods?"
if [ "$?" -eq 0 ]; then
  ./skyrimse-mod-bootstraper.sh
  BOOTSTRAPPED=true
fi
eval "$@"
[ "$BOOTSTRAPPED" = true ] && ./skyrimse-mod-bootstraper.sh --decouple

