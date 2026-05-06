#!/bin/bash

source "$CONFIG_DIR/colors.sh"

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ "$PERCENTAGE" = "" ]; then
  sketchybar --set battery label="N/A"
  exit 0
fi

if [ -n "$CHARGING" ]; then
  ICON="􀢋"
  COLOR=$BLUE
else
  ICON="􀛨"
  if [ "$PERCENTAGE" -ge 60 ]; then
    COLOR=$WHITE
  elif [ "$PERCENTAGE" -ge 30 ]; then
    COLOR=$YELLOW
  else
    COLOR=$RED
  fi
fi

if [ -n "$CHARGING" ] && [ "$PERCENTAGE" -ge 95 ]; then
  COLOR=$GREEN
fi

sketchybar --set battery icon="$ICON" icon.color=$COLOR label="${PERCENTAGE}%"
