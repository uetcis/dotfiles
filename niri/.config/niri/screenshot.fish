#!/bin/fish

niri msg action screenshot$argv
# notify-send "DONE: niri msg action screenshot$argv"
# notify-send shot
sleep 0.1s
# notify-send awake
# wl-paste | satty --filename -
wl-paste | swappy -f - -o - | wl-copy
