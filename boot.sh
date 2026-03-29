#!/bin/bash

ascii_logo='
░█▀█░█▀▄░█▀▀░█░█░█▀█░█░░░▀█▀░█▀▀░░░█░░░▀█▀░█▀█░█░█░█░█
░█▀█░█▀▄░█░░░█▀█░█▀█░█░░░░█░░▀▀█░░░█░░░░█░░█░█░█░█░▄▀▄
░▀░▀░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀'

clear

echo -e "\n$ascii_logo\n"
echo -e "Archalis Linux\n"
echo -e "https://github.com/nathaniel-mallet/archalis-linux\n"

read -rp "Do you want to run the Archalis Linux installation on this machine? (y/n): " answer

if [ "$answer" != "y" ]; then
	echo "Cancelled installation"
	exit 0
fi

echo -e "\nInstalling git and fetching installation files"

# Git
if pacman -Q git &> /dev/null; then
    echo "Skipping git (already installed) ..."
else
    echo "Installing git ..."
    sudo pacman -S --noconfirm git
fi

git clone "https://github.com/nathaniel-mallet/archalis-linux.git" ~/.local/share/archalis >/dev/null

echo -e "\nStarting installation ...\n"
source "~/.local/share/archalis/scripts/install/install.sh"
