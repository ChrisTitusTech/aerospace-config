#!/bin/bash

APP_NAME=$INFO
sketchybar --set front_app label="$APP_NAME"
    done <<< "${apps}"
  else
    icon_strip=" —"
  fi
  sketchybar --set space.$AEROSPACE_FOCUSED_MONITOR_NO label="$icon_strip"
fi
