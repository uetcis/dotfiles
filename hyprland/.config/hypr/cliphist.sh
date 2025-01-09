#!/bin/sh

app_id=$(hyprctl activewindow -j | jq --raw-output .class )
app_title=$(hyprctl activewindow -j | jq --raw-output .title)
if [[ $app_id != "org.keepassxc.KeePassXC" ]]; then
	if [[ $app_id != "Bitwarden" ]]; then
		echo $app_title | grep 'Bitwarden' > /dev/null
		if [[ $? -ne 0 ]]; then
			cliphist store
		fi
	fi
fi
