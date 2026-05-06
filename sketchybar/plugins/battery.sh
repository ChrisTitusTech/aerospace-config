#!/bin/bash

BATT=$(pmset -g batt)
PERCENTAGE=$(echo "$BATT" | grep -Eo "[0-9]+%" | cut -d% -f1)

[ -z "$PERCENTAGE" ] && sketchybar --set battery label="N/A" && exit 0

if echo "$BATT" | grep -q 'AC Power'; then
  ICON="􀢋"
  COLOR=0xff81a1c1
  [ "$PERCENTAGE" -ge 95 ] && COLOR=0xffa3be8c
else
  ICON="􀛨"
  if   [ "$PERCENTAGE" -ge 60 ]; then COLOR=0xffd8dee9
  elif [ "$PERCENTAGE" -ge 30 ]; then COLOR=0xffebcb8b
  else                                  COLOR=0xffbf616a
  fi
fi

sketchybar --set battery icon="$ICON" icon.color="$COLOR" label=" ${PERCENTAGE}%"
