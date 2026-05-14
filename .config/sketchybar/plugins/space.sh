#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

if [ "$SELECTED" = "true" ]; then
  # Animate highlighting and slight vertical shift
  sketchybar --animate linear 5 --set "$NAME" background.color=0xFFBD4720 \
	     icon.color=0xffffffff icon.padding_left=20 label.padding_right=20 label.padding_left=10
else
  # Reset non-selected spaces smoothly
  sketchybar --animate linear 5 --set "$NAME" background.color=0x00BD4720 \
	     icon.color=0x00BD4720 icon.padding_left=0 label.padding_right=10 label.padding_left=-15
fi
