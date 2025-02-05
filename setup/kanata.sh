#!/bin/bash

echo -ne "username: "
read username

sudo groupadd uinput
sudo usermod -aG input $username
sudo usermod -aG uinput $username

sudo mkdir -p /etc/udev/rules.d/
sudo touch /etc/udev/rules.d/99-input.rules
sudo echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' | sudo tee /etc/udev/rules.d/50-kanata.rules > /dev/null
sudo echo "KERNEL==\"uinput\", MODE=\"0660\", GROUP=\"uinput\", OPTIONS+=\"static_node=uinput\"" > /etc/udev/rules.d/99-input.rules
sudo udevadm control --reload-rules && sudo udevadm trigger
ls -l /dev/uinput

sudo modprobe uinput
mkdir -p ~/.config/systemd/user

kanataconfig="[Unit]
Description=Kanata keyboard remapper
Documentation=https://github.com/jtroo/kanata
Wants=modprobe@uinput.service
After=modprobe@uinput.service

[Service]
Type=simple
ExecStartPre=/usr/bin/modprobe uinput
ExecStart=/usr/bin/kanata --quiet --cfg /home/${username}/.config/kanata/config.kbd
Restart=no

[Install]
#WantedBy=default.target
WantedBy=sysinit.target
" 

sudo echo "$kanataconfig" | sudo tee /etc/systemd/system/kanata.service > /dev/null

sudo systemctl daemon-reload
sudo systemctl enable kanata.service
sudo systemctl start kanata.service
sudo systemctl status kanata.service   # check whether the service is running

