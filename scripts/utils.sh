#!/bin/bash

# Source guard; if this file is sourced more than once, 
# this will ensure that its contents aren't redefined.
# It's a bit overkill for now since this file only defines functions,
# but it's good practice in case variables are added later.
if [ -n "$_UTILS_SH_LOADED" ]; then
    return
fi
_UTILS_SH_LOADED=1

# Helper function for install messages
install() {
	if pacman -Q $1 &> /dev/null; then
		echo "$1 - skipped (already installed)"
	else
		echo "installing $1 ..."
		sudo pacman -S --noconfirm $1
	fi
}

yay_install() {
	if yay -Q $1 &> /dev/null; then
		echo "$1 is already installed, skipping ..."
	else
		echo "Installing $1 ..."
		yay -S --noconfirm $1
	fi
}

check_command() {
	command -v "$1" &> /dev/null
}
