# i3-dotfiles

Configuração do meu **i3wm** (Arch Linux), inspirada em
[harshrajsachan/stow-dotfiles](https://github.com/harshrajsachan/stow-dotfiles),
adaptada ao que já estava instalado aqui.

- **WM**: i3 (gaps + bordas 0 via `i3.conf`)
- **Barra**: polybar (topo com workspaces/sistema, inferior com progresso da música)
- **Launcher/menus**: rofi (drun, janelas, emoji, calculadora, WiFi)
- **Terminal**: kitty · **Gerenciador de arquivos**: Thunar · **Editor**: nvim/yazi
- **Compositor**: picom · **Notificações**: dunst · **Lock**: i3lock (blur do wallpaper)

## Estrutura

Layout pronto para [GNU Stow](https://www.gnu.org/software/stow/):

```
i3/          ~/.config/i3          (config + i3.conf)
i3lock/      ~/.config/i3lock
polybar/     ~/.config/polybar
rofi/        ~/.config/rofi
picom/       ~/.config/picom
dunst/       ~/.config/dunst
xsettingsd/  ~/.config/xsettingsd
scripts/     ~/.config/scripts    (scripts usados pelo i3/polybar)
local-bin/   ~/.local/bin         (menus: launcher, wmmenu, powermenu, lock...)
```

## Instalação

Cópia simples:

```sh
# para cada pacote, ex.: i3, polybar, scripts, local-bin
cp -r i3/.config ~/.config
cp -r local-bin/.local ~/.local
```

Ou com Stow (recomendado — mantém symlinks, edições refletem no repo):

```sh
sudo pacman -S stow
stow -d ~/i3-dotfiles -t ~ i3 i3lock polybar rofi picom dunst xsettingsd scripts local-bin
```

> O polybar usa a paleta do pywal (`~/.cache/wal/polybar-colors.ini`).
> Se ela não existir, `scripts/launch_polybar.sh` cria um fallback.

## Dependências

- **i3-gaps / i3**, polybar, rofi, picom, dunst, kitty, xsettingsd
- playerctl, pamixer, brightnessctl, maim, slop, xdotool
- autotiling, i3-swallow-git (binário `swallow`), xautolock
- JetBrainsMono Nerd Font, pywal (`wal`/`ruwall`)

## Atalhos principais

| Tecla | Ação |
|---|---|
| `Super+Enter` | kitty |
| `Super+d` | rofi (apps) |
| `Super+Tab` | menu de comandos (wmmenu) |
| `Alt+Tab` | alternar janelas (rofi) |
| `Super+q` | fechar janela |
| `Super+Setas` | foco / mover janela |
| `Super+Ctrl+Setas` | redimensionar |
| `Super+1..0` | workspaces 1–10 |
| `Super+F` | fullscreen |
| `Super+Print` | screenshot de área |
| `Print` | screenshot da tela |
| `Super+Shift+X` | travar (i3lock) |
| `Super+Shift+G` | alternar gaps |

Para a lista completa de comandos, use o `wmmenu` (`Super+Tab`).