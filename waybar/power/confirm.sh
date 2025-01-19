#!/bin/bash

choice=$1
id=$(ps -ef | grep '[w]aybar -c' | grep confirm | awk '{print $2}')

if [ $choice = logout ]; then
  waybar -c $HOME/.config/waybar/power/confirm/logout.jsonc -s $HOME/.config/waybar/power/confirm/style.css
elif [ $choice = reboot ]; then
  waybar -c $HOME/.config/waybar/power/confirm/reboot.jsonc -s $HOME/.config/waybar/power/confirm/style.css
elif [ $choice = poweroff ]; then
  waybar -c $HOME/.config/waybar/power/confirm/poweroff.jsonc -s $HOME/.config/waybar/power/confirm/style.css
else
  kill "$id"
fi
