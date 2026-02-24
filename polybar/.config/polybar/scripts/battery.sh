#!/bin/bash

BAT_PATH=$(upower -e | grep 'battery' | head -n 1)

if [ -z "$BAT_PATH" ]; then
  echo "No Battery"
  exit 0
fi

PERC=$(upower -i "$BAT_PATH" | grep -E "percentage:" | awk '{print $2}' | tr -d '%' | cut -d'.' -f1)
STAT=$(upower -i "$BAT_PATH" | grep -E "state:" | awk '{print $2}')

if [ "$STAT" = "charging" ] || [ "$STAT" = "fully-charged" ]; then
  ICON="󱐋"
elif [ "$PERC" -gt 80 ]; then
  ICON=""
elif [ "$PERC" -gt 60 ]; then
  ICON=""
elif [ "$PERC" -gt 40 ]; then
  ICON=""
elif [ "$PERC" -gt 20 ]; then
  ICON=""
else
  ICON=""
fi

echo "$ICON $PERC%"
