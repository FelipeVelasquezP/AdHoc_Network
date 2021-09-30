#!/bin/bash

echo "stopping and unloading batman-adv kernel module"
rmmod batman-adv
echo "starting Network Manager"
if [ -f /etc/debian_version ]; then
	service network-manager restart
elif [[ -f /etc/redhat-release ]] || [[ -f /etc/arch-release ]]; then
	NetworkManager
fi
