#!/bin/fish

set id (niri msg -j focused-window | jq ".app_id")

if echo $id | grep 'org.freedesktop.Xwayland' > /dev/null
  killall rofi || env -u WAYLAND_DISPLAY -u XDG_SESSION_TYPE GTK_IM_MODULE=fcitx DISPLAY=:0 rofi -show drun -dpi 163
else
  killall fuzzel || fuzzel
end
