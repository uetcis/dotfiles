#!/bin/env fish
logger "swaync handler.fish $argv"

if test (swaync-client -D) = "true"
  logger "swaync handler.fish $argv[1] muted"
else 
  pw-cat --volume 1.5 -p ~/.config/swaync/eurosounds/Sounds/private_message.wav
end

switch $argv[1];
  case 'nheko'
    # env | grep SWAYNC | logger
    set RES (printenv SWAYNC_BODY | ollama run modelfile_sms_otp)
    # logger $RES
    if test "$RES" != "NULL"
      echo $RES | wl-copy 
      pw-cat --volume 1.5 -p ~/.config/swaync/eurosounds/Sounds/handoff_accept.wav 
    end
end
