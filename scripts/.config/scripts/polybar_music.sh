#!/usr/bin/env bash
# ~/.config/scripts/polybar_music.sh
# Módulo MPRIS genérico para polybar (playerctl) com marquee

MAX_LEN=28
SCROLL_OFFSET="$HOME/.cache/mpris-scroll.offset"
SCROLL_KEY="$HOME/.cache/mpris-scroll.key"

get_active_player() {
    local p
    while read -r p; do
        [[ "$(playerctl -p "$p" status 2>/dev/null)" == "Playing" ]] && { printf '%s' "$p"; return; }
    done < <(playerctl -l 2>/dev/null)
    playerctl -l 2>/dev/null | head -1
}

player=$(get_active_player)
if [[ -z "$player" ]]; then
    printf '%s' ""
    exit 0
fi

status=$(playerctl -p "$player" status 2>/dev/null)
artist=$(playerctl -p "$player" metadata artist 2>/dev/null)
title=$(playerctl -p "$player" metadata title 2>/dev/null)

case "$status" in
    Playing) icon=" " ;;
    Paused)  icon=" " ;;
    *)       icon="   " ;;
esac

text="$artist - $title"

if [[ ${#text} -le $MAX_LEN ]]; then
    printf '%s %s' "$icon" "$text" | sed 's/%/%%/g'
    rm -f "$SCROLL_OFFSET" "$SCROLL_KEY"
    exit 0
fi

key=$(printf '%s' "$text" | md5sum | cut -d' ' -f1)
prev_key=$(cat "$SCROLL_KEY" 2>/dev/null)

if [[ "$key" != "$prev_key" ]]; then
    printf '%s' "$key" > "$SCROLL_KEY"
    offset=0
else
    offset=$(($(cat "$SCROLL_OFFSET" 2>/dev/null || echo 0) + 1))
fi

len=${#text}
offset=$((offset % len))
printf '%s' "$offset" > "$SCROLL_OFFSET"

padded="${text} $(printf '%*s' "$MAX_LEN" '')"
window="${padded:offset:MAX_LEN}"

printf '%s %s' "$icon" "$window" | sed 's/%/%%/g'