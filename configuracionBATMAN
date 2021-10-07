#!/bin/bash

#Modo 
modprobe batman-adv
#Se para el proseso de red de la maquina
sudo pkill NetworkManager
#se apaga la interfaz wan de la maquina y se asigna el modo adhoc
ifconfig wlan0 down
iwconfig wlan0 mode ad-hoc 

ifconfig wlan0 mtu 1532
#Asignacion del acces point y el channel
iwconfig wlan0 mode ad-hoc essid RED-Adhoc ap 02:1B:55:AD:0C:02  channel 1 
sleep 1
#Se enciende la interfaz wan de la maquina
ip link set wlan0 up 
sleep 1
#Se asigna la interfaz virtual de BATMAN a la WAN
batctl if add wlan0
ifconfig bat0 up
#Se asigna la IP a la interfaz virtual
ifconfig bat0 192.168.0.3

echo "Configuracion realizada exitosamente"
