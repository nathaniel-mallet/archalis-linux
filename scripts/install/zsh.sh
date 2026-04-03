#!/bin/bash

mkdir -p ~/.zsh

# zsh
install zsh
if [ $SHELL != "$(which zsh)" ]; then
	echo "Setting zsh as default shell ..."
	chsh -s $(which zsh)
else
	echo "zsh is already the default shell, skipping"
fi

# oh my zsh
# if [ ! -d "$HOME/.oh-my-zsh" ]; then
# 	echo "Installing Oh My Zsh ..."
# 	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# else
# 	echo "Oh My Zsh - skipped (already installed)"
# fi