#!/bin/bash

install nvidia-open
install nvidia-utils
install nvidia-settings
sudo mkinitcpio -P
echo "You should reboot the computer at this point to load the Nvidia driver. Once that's done, run 'nvidia-smi' to verify that the driver is working"
