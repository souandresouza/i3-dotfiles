#!/usr/bin/env bash

# Termina instâncias do polybar que possam estar rodando
killall -q polybar

# Espera até que os processos sejam encerrados
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Garante a paleta de cores (fallback Catppuccin se a pywal ainda não rodou)
if [[ ! -f "$HOME/.cache/wal/polybar-colors.ini" ]]; then
    mkdir -p "$HOME/.cache/wal"
    cat > "$HOME/.cache/wal/polybar-colors.ini" <<'EOF'
[colors]
background = #1e1e2e
foreground = #cdd6f4
primary = #89b4fa
secondary = #f5e0dc
alert = #f38ba8
disabled = #6c7086
EOF
fi

# Só i3wm: módulo de workspaces sempre i3
export WM_MODULE=i3

# Lança as barras (topo e inferior) por monitor (nomes detectados automaticamente)
for m in $(polybar --list-monitors | cut -d: -f1); do
    MONITOR="$m" polybar main -r &
    MONITOR="$m" polybar bottom -r &
done