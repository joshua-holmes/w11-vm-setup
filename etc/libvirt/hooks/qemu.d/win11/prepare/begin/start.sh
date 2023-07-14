#!/bin/bash

# Stop window manager and display manager. Change to fit your setup
killall Hyprland
systemctl stop sddm.service

# Unbind from virtual consoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# Change id to match your GPU id using:
# `lspci -k | grep -i -A 3 vga`
gpu=0000:08:00.0
aud=0000:08:00.1
gpu_vd="$(cat /sys/bus/pci/devices/$gpu/vendor) $(cat /sys/bus/pci/devices/$gpu/device)"
aud_vd="$(cat /sys/bus/pci/devices/$aud/vendor) $(cat /sys/bus/pci/devices/$aud/device)"

# Unbind driver
echo -n $gpu > /sys/bus/pci/devices/$gpu/driver/unbind
echo -n $aud > /sys/bus/pci/devices/$aud/driver/unbind

# Bind new driver
echo -n $gpu_vd > /sys/bus/pci/drivers/vfio-pci/new_id
echo -n $aud_vd > /sys/bus/pci/drivers/vfio-pci/new_id

