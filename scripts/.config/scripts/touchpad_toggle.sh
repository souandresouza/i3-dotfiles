#!/bin/bash
# Liga/desliga o touchpad (detecta o dispositivo dinamicamente)

TP=$(xinput list --name-only | grep -iE "touchpad|synap|alps|glide" | head -1)
[ -z "$TP" ] && exit 0

STATE=$(xinput list-props "$TP" | grep "Device Enabled" | awk '{print $NF}')

if [ "$STATE" = "1" ]; then
    xinput disable "$TP"
    notify-send "Touchpad" "Desativado"
else
    xinput enable "$TP"
    notify-send "Touchpad" "Ativado"
fi