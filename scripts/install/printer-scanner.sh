#!/bin/bash

source "$(dirname "$0")/../utils.sh"

# Printer drivers
install cups-pdf
sudo systemctl enable --now cups

yay_install epson-inkjet-printer-escpr
yay_install epson-inkjet-printer-escpr2



# Scanner drivers
install sane
yay_install iscan
yay_install iscan-data

sudo usermod -aG scanner,lp $usermod


# Scanner UI
install simple-scan

# Network printing & scanning
install avahi
install nss-mdns

echo -e "\n\n"
echo "-----------------"
echo " -- IMPORTANT -- "
echo "-----------------"
echo -e "\n"
echo "There are a few manual steps to complete"
echo "Edit /etc/nsswitch.conf and add mdns_minimal to the hosts line, ex:"
echo "  hosts: mtime files mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAILABLE=return] dns"
echo -e "\n"
echo "Navigate to http://localhost:631 and add your printer"
echo -e "\n"
echo "Please restart, then run scanimage -L to ensure the scanner is detected"
echo "If you scanner is not detected, edit /etc/sane.d/epsonds.conf, and replace the autodetect line"
echo "with your printer's IP address. You can find that IP address via CUPS Admin"
