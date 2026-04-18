#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Pick one random wallpaper
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

# Start the daemon
awww-daemon &

# Wait until swww is ready
until awww query &>/dev/null; do
    sleep 0.2
done

# Set the same wallpaper on both monitors
awww img "$WALLPAPER"

