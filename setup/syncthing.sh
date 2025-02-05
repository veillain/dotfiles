#!/bin/bash

echo $USER > /tmp/username.txt
username=$(cat /tmp/username.txt)
userdone="syncthing@${username}"
echo $userdone

syncthingconfig="[Unit]
Description=Syncthing - Sync between devices
Documentation=https://syncthing.net

[Service]
Type=simple
ExecStart=/usr/bin/syncthing
Restart=no

[Install]
WantedBy=default.target
# WantedBy=sysinit.target
" 

sudo echo "$syncthingconfig" | sudo tee /etc/systemd/system/syncthing.service > /dev/null

sudo systemctl daemon-reload
sudo systemctl enable $userdone
sudo systemctl start $userdone
sudo systemctl status syncthing

