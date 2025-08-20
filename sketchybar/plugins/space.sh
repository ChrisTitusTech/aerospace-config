#!/bin/bash

update() {
    source "$CONFIG_DIR/colors.sh"
    COLOR=$BACKGROUND_2
    if [ "$SELECTED" = "true" ]; then
	COLOR=$GREY
    fi
    sketchybar --set space.$(aerospace list-workspaces --focused) icon.highlight=true \
	label.highlight=true \
	background.border_color=$GREY \
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

# echo plugin_space.sh $SENDER >> ~/aaaa
case "$SENDER" in
  *) update
  ;;
esac
