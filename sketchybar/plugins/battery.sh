#!/bin/bash

source "$CONFIG_DIR/colors.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ "$PERCENTAGE" = "" ]; then
  sketchybar --set battery label="N/A"
  exit 0
fi

if [ -n "$CHARGING" ]; then
  ICON="🔌"
  COLOR=$GREEN
else
  ICON="🔋"
  if [ "$PERCENTAGE" -ge 80 ]; then
    COLOR=$GREEN
  elif [ "$PERCENTAGE" -ge 50 ]; then
    COLOR=$YELLOW
  else
    COLOR=$RED
  fi
fi

sketchybar --set battery icon="$ICON" icon.color=$COLOR label="${PERCENTAGE}%"
