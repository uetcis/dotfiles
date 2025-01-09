#!/bin/sh
killall pipewire pipewire-pulse wireplumber
pipewire &
pipewire-pulse &
wireplumber &
