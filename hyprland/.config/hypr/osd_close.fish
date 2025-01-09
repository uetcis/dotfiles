#!/bin/fish
while true
	if test (math (date +%s) - $EWW_LIT) -gt 1
		eww close osd_brightness
	end	
	if test (math (date +%s) - $EWW_VOL) -gt 1
		eww close osd_vol
	end	
	sleep 1
end

