#!/bin/bash

BAT=$(ls /sys/class/power_supply | grep BAT | head -n 1)

if [ -z "$BAT" ]; then
  echo "No Battery"
  exit 0
fi

PERC=$(cat "/sys/class/power_supply/$BAT/capacity")
STAT=$(cat "/sys/class/power_supply/$BAT/status")

if [ "$STAT" = "Charging" ]; then
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
