#!/bin/bash

if route -n get default &>/dev/null; then
  sketchybar --set wifi icon="􀙇" icon.color=0xff81a1c1 label=""
else
  sketchybar --set wifi icon="􀙈" icon.color=0xff3b4252 label=""
fi
