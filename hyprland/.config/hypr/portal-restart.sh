#!/bin/bash
sleep 4
#killall xdg-desktop-portal-wlr
killall xdg-desktop-portal
killall xdg-desktop-portal-hyprland
#/usr/lib/xdg-desktop-portal-wlr &
/usr/lib/xdg-desktop-portal-hyprland &
sleep 4
/usr/lib/xdg-desktop-portal &
