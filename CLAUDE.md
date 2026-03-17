# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a dotfiles repository for Arch Linux systems. It contains shell scripts to automate installation of packages and system configuration. Currently the repo manages package installation only, but dotfiles (`.zshrc`, Hyprland configs, etc.) are planned to be added.

## Running Scripts

```bash
# Main bootstrap (run first)
bash install.sh

# Hyprland window manager setup (run after install.sh)
bash scripts/install/hyprland-install.sh

# Python build dependencies (optional)
bash scripts/install/python_install.sh

# Random wallpaper from ~/Pictures/Wallpapers/
bash scripts/bin/wallpaper.sh
```

No build step, linter, or test framework exists — these are plain shell scripts.

## Architecture

### Three-Stage Installation

1. **`install.sh`** — Core CLI tools, shell setup (zsh + Oh My Zsh), development utilities (git, neovim, tmux, fzf, docker, nvm). Ends by setting zsh as default shell and creating standard home directories.

2. **`scripts/install/hyprland-install.sh`** — Desktop environment layer: Hyprland (Wayland compositor), Waybar, Kitty, rofi, greetd, audio (PipeWire), NVIDIA drivers, GUI apps (Firefox, Slack, Cursor IDE, 1Password).

3. **`scripts/install/python_install.sh`** — Python build dependencies using the shared `install()` helper.

### Shared Helper (`scripts/utils.sh`)

Provides a single `install()` function sourced by all scripts:
- Checks `pacman -Q` before installing (idempotent)
- Uses `sudo pacman -S --noconfirm` for official packages
- AUR packages use `yay` directly in the scripts

### Package Manager Strategy

- Official packages: `install <package>` (via `utils.sh`)
- AUR packages: `yay -S --noconfirm <package>` called directly
- npm globals: `npm install -g <package>` (used for Claude Code, Codex)
- Shell frameworks: direct curl/wget installers (Oh My Zsh, NVM)

## Key Conventions

- All scripts are idempotent — safe to re-run
- Target OS: Arch Linux (pacman/yay assumed)
- Scripts currently manage package installation only; dotfiles will be added in the future
- `scripts/utils.sh` must be sourced before calling `install()`
