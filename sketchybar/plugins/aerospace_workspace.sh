#!/bin/bash

FOCUSED="$AEROSPACE_FOCUSED_WORKSPACE"

# When called outside AeroSpace workspace-change hook (e.g. SketchyBar startup),
# resolve the currently focused workspace directly.
if [ -z "$FOCUSED" ]; then
  FOCUSED="$(aerospace list-workspaces --focused 2>/dev/null | head -n1)"
fi
U=$(printf '\xcc\xb2')  # U+0332 combining underline
ARGS=()

for i in {1..8}; do
  if [ "$i" = "$FOCUSED" ]; then
    ARGS+=(--set "space.$i" "label=${i}${U}" background.color=0xff81a1c1 label.color=0xff2e3440)
  else
    ARGS+=(--set "space.$i" "label=$i" background.color=0xff3b4252 label.color=0xffd8dee9)
  fi
done

/opt/homebrew/opt/sketchybar/bin/sketchybar "${ARGS[@]}"
