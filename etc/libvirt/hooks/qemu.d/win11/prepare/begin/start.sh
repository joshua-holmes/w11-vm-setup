#!/bin/bash

/home/josh/check.sh "start before driver swap"
# stop sddm
killall Hyprland
systemctl stop sddm.service

# unbind from virtual consoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
echo 0 > /sys/class/vtconsole/vtcon1/bind

# unbind from efi-frambuffer
# echo -n "efi-framebuffer.0" > /sys/bus/platform/drivers/efi-framebuffer/unbind

# echo -n "0000:09:00.0" > /sys/bus/pci/drivers/amdgpu/unbind
# rmmod -f amdgpu
# modprobe vfio_pci

gpu=0000:08:00.0
aud=0000:08:00.1
gpu_vd="$(cat /sys/bus/pci/devices/$gpu/vendor) $(cat /sys/bus/pci/devices/$gpu/device)"
aud_vd="$(cat /sys/bus/pci/devices/$aud/vendor) $(cat /sys/bus/pci/devices/$aud/device)"

echo -n $gpu > /sys/bus/pci/devices/$gpu/driver/unbind
echo -n $aud > /sys/bus/pci/devices/$aud/driver/unbind

# echo -n $gpu_vd > /sys/bus/pci/drivers/amdgpu/remove_id
# echo -n $aud_vd > /sys/bus/pci/drivers/amdgpu/remove_id

echo -n $gpu_vd > /sys/bus/pci/drivers/vfio-pci/new_id
echo -n $aud_vd > /sys/bus/pci/drivers/vfio-pci/new_id

/home/josh/check.sh "start after driver swap"
