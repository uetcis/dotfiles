#!/bin/fish

while true
  set INFO (niri msg -j focused-window)
  set TITLE (echo $INFO | jq ".title" -r)
  set CLASS (echo $INFO | jq ".app_id" -r)
  echo (jq --null-input \
  --arg title "$TITLE" \
  --arg tooltip "$CLASS" \
  '{"text": $title, "tooltip": $tooltip}')
  sleep 0.2
end
