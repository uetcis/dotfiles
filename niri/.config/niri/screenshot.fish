#!/bin/fish

niri msg action screenshot$argv
sleep 0.5
wl-paste | satty --filename -
# wl-paste | swappy -f - -o - | wl-copy
