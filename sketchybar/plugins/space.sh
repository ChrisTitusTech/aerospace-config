#!/bin/bash

source "$CONFIG_DIR/colors.sh"

workspace_num="${NAME#space.}"
underlined_workspace_num="${workspace_num}̲"
focused_workspace="${AEROSPACE_FOCUSED_WORKSPACE:-$FOCUSED_WORKSPACE}"
live_focused_workspace="$(aerospace list-workspaces --focused 2>/dev/null | tr -d '[:space:]')"
if [ -n "$live_focused_workspace" ]; then
    focused_workspace="$live_focused_workspace"
fi
window_count="$(aerospace list-windows --workspace "$workspace_num" 2>/dev/null | wc -l | tr -d ' ')"

if [ -z "$window_count" ]; then
    window_count=0
fi

if [ "$window_count" -eq 0 ]; then
    sketchybar --set "$NAME" drawing=off
    exit 0
fi

sketchybar --set "$NAME" drawing=on

if [ "$workspace_num" = "$focused_workspace" ]; then
        sketchybar --set "$NAME" \
            label="$underlined_workspace_num" \
            background.color=$BLUE \
            label.color=$BG0
else
        sketchybar --set "$NAME" \
            label="$workspace_num" \
            background.color=$BG2 \
            label.color=$WHITE
fi
