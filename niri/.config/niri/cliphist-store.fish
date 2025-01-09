#!/bin/fish

set title (niri msg -j focused-window | jq ".title")

if echo $title | grep 'Bitwarden' > /dev/null
  echo password redacted
else
  cliphist store
end
