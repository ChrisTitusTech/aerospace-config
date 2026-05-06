#!/bin/bash

APP_NAME="$INFO"

if [ -z "$APP_NAME" ]; then
	APP_NAME="Desktop"
fi

sketchybar --set front_app label="$APP_NAME"
