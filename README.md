# Archalis Linux 
Archalis Linux is a set of install scripts and configuration files for a minimalistic [Arch Linux](https://archlinux.org/) development setup.

This is primarily a hobby/learning project, and some of the configuration is specific to the hardware I'm using to develop this install. YMMV.

## Packages & Highlights
* Wayland
* Hyprland
* Codex, Claude & OpenClaw
* NeoVim with a few plugins (Neo-tree, NVim Treesitter and Telescope) 

## Pre-requisites
* Archalis uses zsh as the default, and so some of the setup and configuration files will use zsh (ex: `aliases.zsh`)

## Installation
1. Complete the basic Arch OS installation found on the [Beginning Instal Guide](https://wiki.archlinux.org/title/Installation_guide)
2. Run the following command: `wget https://github.com/nathaniel-mallet/dotfiles/releases/download/0.1/install.sh | bash`
3. Run the various install scripts found in the `scripts\install` folder for whatever you need or would like to have installed in your environment. At a minimum, you should run `hyprland-install.sh`, to complete the Hyprland installation.

## Repo Structure
* config - contains all config files, as well as ZSH scripts used as configuration (ex: `aliases.zsh`)
* scripts - all `.sh` files
* scripts/bin - Scripts that will be installed with Archalis to handle various tasks (like wallpaper switching)
* scripts/install - All of the one-time installation scripts

## Contributing
I'm not currently accepting contribution, just because this is still very much work in progress, and because it's very specific to my hardware. But I am hoping to open it up in the future. If you really want to make changes, then just fork it!

