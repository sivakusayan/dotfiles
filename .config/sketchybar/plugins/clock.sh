#!/bin/sh

# The $NAME variable is passed from sketchybar
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

day=$(date +%-d)

case $day in
    1|21|31) suffix="st" ;;
    2|22)    suffix="nd" ;;
    3|23)    suffix="rd" ;;
    *)       suffix="th" ;;
esac

# Use double quotes for the format string to allow variable expansion
sketchybar --set "$NAME" label="$(date +"%b ${day}${suffix}, %Y - %-I:%M%p")"
