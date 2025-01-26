#!/bin/bash

config="$HOME/.config/hypr/hyprland.conf"
lines=$(cat $HOME/.config/hypr/hyprland.conf | grep address: | awk '{print $5}')
blurbgid=$(hyprctl layers | grep 1420 | awk '{print $2}' | sed 's/://')

sed -i "s/address:0x$lines/address:0x$blurbgid/g" $config
