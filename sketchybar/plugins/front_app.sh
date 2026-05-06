#!/bin/bash

APP_NAME="$INFO"

if [ -z "$APP_NAME" ]; then
	APP_NAME="$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)"
fi

if [ -z "$APP_NAME" ]; then
	APP_NAME="Desktop"
fi

sketchybar --set front_app label="$APP_NAME"

# Re-sync workspace highlight with a fresh WM query to avoid stale focus state.
FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused 2>/dev/null | tr -d '[:space:]')"
if [ -n "$FOCUSED_WORKSPACE" ]; then
	sketchybar --trigger aerospace_workspace_change AEROSPACE_FOCUSED_WORKSPACE="$FOCUSED_WORKSPACE"
fi
