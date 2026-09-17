#!/bin/bash
# Alterna gaps interno 0 <-> 4 (útil p/ apresentações e screenshots)

STATE_FILE="/tmp/i3_gap_state"

[ ! -f "$STATE_FILE" ] && echo "4" >"$STATE_FILE"
STATE=$(cat "$STATE_FILE")

if [ "$STATE" = "4" ]; then
    i3-msg "gaps inner current set 0; gaps outer current set 0" >/dev/null
    echo "0" >"$STATE_FILE"
    notify-send "Gaps" "OFF"
else
    i3-msg "gaps inner current set 4; gaps outer current set 1" >/dev/null
    echo "4" >"$STATE_FILE"
    notify-send "Gaps" "ON"
fi