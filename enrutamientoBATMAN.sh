#!/bin/bash

echo "Stopping Network Manager"
if [ -f /etc/debian_version ]; then
	sudo service network-manager stop
elif [[ -f /etc/redhat-release ]] || [[ -f /etc/arch-release ]]; then
	sudo pkill NetworkManager
fi

echo "Loading batman-adv kernel module"
modprobe batman-adv
sleep 2

ip link set up dev eth0
ip link set mtu 1532 dev wlan0

#El pymesh se puede cambiar a el otro script
echo "switching to ad-hoc mode - PYMESH"
iwconfig wlan0 mode ad-hoc channel 6 essid PYMESH ap 02:12:34:56:78:9A enc off

echo "adding wireless interface to batman"
batctl if add wlan0

echo "bringing up wireless ad-hoc interface"
ifconfig wlan0 up

echo "bringing up bat0 interface"
ifconfig bat0 up
#LA ip debe ser diferente para cada dispositivo en su ultiimo octeto
ifconfig bat0 192.168.1.4 up

echo "Nodo configurado Exitosamente"
