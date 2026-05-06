#!/bin/bash

source "$CONFIG_DIR/colors.sh"

# Online if we have a default route and can reach a public IP quickly.
if route -n get default >/dev/null 2>&1 && ping -q -c 1 -W 1000 1.1.1.1 >/dev/null 2>&1; then
  sketchybar --set wifi icon="􀙇" icon.color=$BLUE label=""
else
  sketchybar --set wifi icon="􀙈" icon.color=$BG2 label=""
fi
