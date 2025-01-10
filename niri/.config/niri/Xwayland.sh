#! /usr/bin/env sh
env Xwayland :0 -hidpi -force-xrandr-emulation &
sleep 1
env -u WAYLAND_DISPLAY -u XDG_SESSION_TYPE GTK_IM_MODULE=fcitx WINIT_X11_SCALE_FACTOR=2 GDK_SCALE=2 DISPLAY=:0 xmonad
