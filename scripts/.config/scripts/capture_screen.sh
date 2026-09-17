#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="$HOME/.cache/screens"
mkdir -p "$OUT_DIR"
OUT="$OUT_DIR/last.png"

case "${1:-all}" in
    region)
        if command -v maim >/dev/null 2>&1; then
            sleep 0.3
            maim -s "$OUT"
        else
            import -window root "$OUT"
        fi
        ;;
    window)
        import -window "$(xdotool getactivewindow 2>/dev/null)" "$OUT" 2>/dev/null || maim --window "$(xdotool getactivewindow 2>/dev/null)" "$OUT"
        ;;
    *)
        if command -v maim >/dev/null 2>&1; then
            maim "$OUT"
        else
            import -window root "$OUT"
        fi
        ;;
esac

echo "Capturado: $OUT"

if command -v tesseract >/dev/null 2>&1; then
    LANGS=por
    tesseract --list-langs 2>/dev/null | grep -q '^eng$' && LANGS="por+eng"
    tesseract "$OUT" "$OUT" -l "$LANGS" >/dev/null 2>&1 || true
    echo "OCR: $OUT.txt"
else
    echo "tesseract não instalado"
fi