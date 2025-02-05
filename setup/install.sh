#!/bin/bash

# Showing asterisk when typing password (sudo)
visudofiles="/etc/sudoers"
visudocheck=$(cat /etc/sudoers | grep "Defaults env_reset")
if [ "$visudocheck" ]; then
	echo "show asterisk done"
else
	echo "Defaults env_reset,pwfeedback" >> $visudofiles
fi

# Make Hyprland launch on boot
greetdfiles="/etc/greetd/config.toml"
echo "Type your username: "
read username
sed -i 's|^command = ".*"|command = "hyprland"|' $greetdfiles
sed -i "s|^user = ".*"|user = \"$username\"|" $greetdfiles
sudo systemctl enable greetd

# Kanata Setup

