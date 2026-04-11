#!/bin/bash

mkdir -p ~/.zsh

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Copy zsh config files
cp "$DOTFILES_DIR/config/aliases.zsh" ~/.zsh/aliases.zsh
cp "$DOTFILES_DIR/config/functions.zsh" ~/.zsh/functions.zsh

# Append source commands to ~/.zshrc if not already present
for file in aliases functions; do
	if ! grep -qF "source ~/.zsh/${file}.zsh" ~/.zshrc 2>/dev/null; then
		echo "source ~/.zsh/${file}.zsh" >> ~/.zshrc
	fi
done

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