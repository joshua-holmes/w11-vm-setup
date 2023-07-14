#!/bin/bash

# Change id to match your GPU id using:
# `lspci -k | grep -i -A 3 vga`
gpu=0000:08:00.0
aud=0000:08:00.1
gpu_vd="$(cat /sys/bus/pci/devices/$gpu/vendor) $(cat /sys/bus/pci/devices/$gpu/device)"
aud_vd="$(cat /sys/bus/pci/devices/$aud/vendor) $(cat /sys/bus/pci/devices/$aud/device)"

# Unbind driver
echo $gpu > /sys/bus/pci/devices/$gpu/driver/unbind
echo $aud > /sys/bus/pci/devices/$aud/driver/unbind

# Bind new driver
echo $gpu > /sys/bus/pci/drivers/amdgpu/bind
echo $aud > /sys/bus/pci/drivers/snd_hda_intel/bind

# Attempt rebind to virtual consoles
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind

# Restart window manager and display manager. Change to fit your setup
systemctl start sddm.service
hyprland-wrapped &

