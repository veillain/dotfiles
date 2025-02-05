#!bin/bash

id=$(ps -ef | grep '[w]aybar -c' | grep power | awk '{print $2}')

if [ "$id" ]; then
    kill $id & pkill -x rofi
else 
    waybar -c $HOME/.config/waybar/power/config.jsonc -s $HOME/.config/waybar/power/style.css
fi
