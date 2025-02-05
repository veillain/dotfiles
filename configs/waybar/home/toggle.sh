#!/bin/bash

status=$(ps -ef | grep '[w]aybar -c' | grep home/config | awk '{print $2}')

if [ "$status" ]; then
  kill $status
  pkill -x rofi
else
  waybar -c $HOME/.config/waybar/home/config.jsonc -s $HOME/.config/waybar/home/style.css
fi
