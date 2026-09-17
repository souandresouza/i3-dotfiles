#!/usr/bin/env bash
# Menu WiFi via nmcli + rofi
set -euo pipefail

profiles=$(nmcli -t -f NAME,TYPE connection show 2>/dev/null | grep ':802-11-wireless' | sed 's/:802-11-wireless$//' | sort -u)

if [ -z "$profiles" ]; then
    notify-send "WiFi" "Nenhuma rede salva"
    exit 0
fi

chosen=$(printf '%s\n' "$profiles" | rofi -dmenu -i -l 10 -p "WiFi") || exit 0

if nmcli connection up "$chosen" 2>/dev/null; then
    notify-send "WiFi" "Conectado a: $chosen"
else
    notify-send "WiFi" "Falha ao conectar: $chosen"
fi