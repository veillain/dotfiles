#!bin/bash

id=$(ps -ef | grep '[w]aybar -c' | grep power | awk '{print $2}')

kill $id || waybar -c $HOME/.config/waybar/power/config.jsonc -s $HOME/.config/waybar/power/style.css
