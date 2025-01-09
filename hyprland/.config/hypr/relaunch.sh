#!/bin/sh
hyprctl dispatch exec "[workspace 2 silent] telegram-desktop"
hyprctl dispatch exec "[workspace 2 silent] webcord --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime"
hyprctl dispatch exec "[workspace 3 silent] element-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime"
hyprctl dispatch exec "[workspace 3 silent] quasselclient"
hyprctl dispatch exec "[workspace 10 silent] bitwarden-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime"
hyprctl dispatch exec "[workspace 10 silent] strawberry"
hyprctl dispatch exec "sleep 1 && /usr/bin/nextcloud"
