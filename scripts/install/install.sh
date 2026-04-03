#!/bin/bash

source "$(dirname "$0")/scripts/utils.sh"

# Git
# If this was kicked off using boot.sh, then git should already be installed
# But it doesn't hurt to try again, just in case the repo was manually cloned
install git

git clone "https://github.com/nathaniel-mallet/archalis-linux.git" ~/.local/share/archalis >/dev/null

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

# Run the individual install scripts
# Eventually, this will be a menu for users to pick and choose what to install
source "./scripts/install/neovim.sh"
source "./scripts/install/zsh.sh"
source "./scripts/install/system.sh"
source "./scripts/install/terminal-tools.sh"
source "./scripts/install/nvidia.sh"
source "./scripts/install/hyprland.sh"
source "./scripts/install/screenshots.sh"
source "./scripts/install/development.sh"
source "./scripts/install/python.sh"
source "./scripts/install/ai.sh"
