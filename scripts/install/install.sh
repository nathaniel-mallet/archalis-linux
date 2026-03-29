#!/bin/bash

source "$(dirname "$0")/scripts/utils.sh"

# Git
# If this was kicked off using boot.sh, then git should already be installed
# But it doesn't hurt to try again, just in case the repo was manually cloned
install git

git clone "https://github.com/nathaniel-mallet/archalis-linux.git" ~/.local/share/archalis >/dev/null

# Neovim
install neovim

# zsh
install zsh
if [ $SHELL != "$(which zsh)" ]; then
	echo "Setting zsh as default shell ..."
	chsh -s $(which zsh)
else
	echo "zsh is already the default shell, skipping"
fi

# oh my zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Installing Oh My Zsh ..."
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
	echo "Oh My Zsh - skipped (already installed)"
fi

# ssh
install openssh
install ksshaskpass

# create default directories
dirs=(
"$HOME/Documents"
"$HOME/Downloads"
"$HOME/Projects"
"$HOME/Pictures"
)
for dir in "${dirs[@]}"; do
	if [ ! -d "$dir" ]; then
		echo "Creating $dir ..."
		mkdir -p "$dir"
	else
		echo "$dir - skipped (already exists"
	fi
done

# tmux
install tmux

# yay
if ! command -v yay &> /dev/null; then
	echo "Installing yay ..."
	git clone https://aur.archlinux.org/yay.git
	cd yay
	makepkg -si --noconfirm
	cd ..
	rm -rf yay
else
	echo "yay - skipped (already installed)"
fi 

source "./scripts/install/system.sh"
source "./scripts/install/nvidia.sh"
source "./scripts/install/hyprland-install.sh"
