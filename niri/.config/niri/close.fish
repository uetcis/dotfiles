#!/bin/fish

set id (niri msg -j focused-window | jq ".app_id")

if echo $id | grep 'org.freedesktop.Xwayland' > /dev/null
else
  niri msg action close-window
end
