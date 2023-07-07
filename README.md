This is just a repo for me to store my VM setup with GPU passthrough. If someone else finds it useful to view what I did, great!

I used [this project]() to setup hooks for libvirt. The only thing you need from it is to place the `qemu` file in `/etc/libvirt/hooks/`. I didn't include this `qemu` script in here because it's not mine and I wanted to give credit where it's due. After you install the hook plugin, place the individual hooks that I wrote from this repo in the correct folders. The file structure does matter for this hook system.

The start hook I wrote will shutdown all Linux GUIs, unbind my GPU from the `amdgpu` driver, then bind it to `vfio_pci` driver, which is necessary for the VM to use it. 

The stop hook will do the reverse and ultimately start Linux GUI back up with the `amdgpu` driver bound to the GPU again and usable by Linux. It works consistently.

The XML file is just my libvirt configuration. Hopefully it's useful.

If you want to use any of this yourself, you will need to go through and customize it to your machine.
