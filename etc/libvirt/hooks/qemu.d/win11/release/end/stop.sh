#!/bin/bash

# echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
# echo 1 > /sys/bus/pci/devices/0000:01:00.1/remove
# echo 1 > /sys/bus/pci/rescan

# reload amd driver
# echo -n "0000:09:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
# rmmod -f vfio_pci
# modprobe -a amdgpu
# echo -n "0000:09:00.0" > /sys/bus/pci/drivers/vfio-pci/unbind
# echo -n "0000:09:00.0" > /sys/bus/pci/drivers/amdgpu/bind






gpu=0000:08:00.0
aud=0000:08:00.1
gpu_vd="$(cat /sys/bus/pci/devices/$gpu/vendor) $(cat /sys/bus/pci/devices/$gpu/device)"
aud_vd="$(cat /sys/bus/pci/devices/$aud/vendor) $(cat /sys/bus/pci/devices/$aud/device)"

echo $gpu > /sys/bus/pci/devices/$gpu/driver/unbind
echo $aud > /sys/bus/pci/devices/$aud/driver/unbind

# echo $gpu_vd > /sys/bus/pci/drivers/vfio-pci/remove_id
# echo $aud_vd > /sys/bus/pci/drivers/vfio-pci/remove_id

echo $gpu > /sys/bus/pci/drivers/amdgpu/bind
echo $aud > /sys/bus/pci/drivers/snd_hda_intel/bind

# attempt rebind to virtual consoles
echo 1 > /sys/class/vtconsole/vtcon0/bind
echo 1 > /sys/class/vtconsole/vtcon1/bind

# restart sddm
systemctl start sddm.service
hyprland-wrapped &

/home/josh/check.sh "stop after driver swap"
