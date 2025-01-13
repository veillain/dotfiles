#!/bin/bash

id=$(ps -ef | grep '[w]aybar -c' | grep power | awk '{print $2}')

if [ -n "$id" ]; then
  kill  $id
else
  waybar -c $HOME/.config/waybar/power/config.jsonc -s $HOME/.config/waybar/power/style.css
fi
