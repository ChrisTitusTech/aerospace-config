#!/bin/bash

APP_NAME="$INFO"

if [ -z "$APP_NAME" ]; then
	APP_NAME="$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true' 2>/dev/null)"
fi

if [ -z "$APP_NAME" ]; then
	APP_NAME="Desktop"
fi

sketchybar --set front_app label="$APP_NAME"
