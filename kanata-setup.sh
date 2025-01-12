#!/bin/bash

sudo groupadd uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER

sudo mkdir -p /etc/udev/rules.d/
sudo touch /etc/udev/rules.d/99-input.rules
sudo echo "KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"" > /etc/udev/rules.d/99-input.rules
sudo udevadm control --reload-rules && sudo udevadm trigger
ls -l /dev/uinput

sudo modprobe uinput
mkdir -p ~/.config/systemd/user

echo "[Unit]
Description=Kanata keyboard remapper
Documentation=https://github.com/jtroo/kanata

[Service]
Environment=PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin
# CPUSchedulingPolicy=rr
# CPUSchedulingPriority=99
# IOSchedulingClass=realtime
# Nice=-20
Type=simple
ExecStart=/usr/bin/sh -c 'exec $$(which kanata) --cfg $${HOME}/.config/kanata/config.kbd'
Restart=no

[Install]
WantedBy=default.target
" > ~/.config/systemd/user/kanata.service

systemctl --user daemon-reload
systemctl --user enable kanata.service
systemctl --user start kanata.service
systemctl --user status kanata.service   # check whether the service is running

reboot
