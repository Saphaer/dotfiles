#!/bin/bash

WALL_DIR="$HOME/wallpapers"

if [ ! -d "$WALL_DIR" ]; then
  echo "Directory $WALL_DIR does not exist."
  exit 1
fi

# Use chafa for the preview inside the fzf window
SELECT=$(ls "$WALL_DIR" | fzf --preview "chafa -s 50x50 $WALL_DIR/{}")

[ -z "$SELECT" ] && exit

# Apply theme with pywal16 (using -e to avoid the session crash)
wal -i "$WALL_DIR/$SELECT" -e

# Source colors for bspwm and polybar
. "$HOME/.cache/wal/colors.sh"

# Update bspwm borders
bspc config focused_border_color "$color2"
bspc config normal_border_color "$color0"

# Reload Polybar safely
if pgrep -x polybar >/dev/null; then
  polybar-msg cmd restart
fi

# Set the actual desktop wallpaper
feh --bg-fill "$WALL_DIR/$SELECT"

# Force Alacritty to pick up the new import (fixes the 'no-reload' issue)
touch ~/.config/alacritty/alacritty.toml
