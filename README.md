# aerospace-config

Minimal AeroSpace + Sketchybar setup for macOS. Tiling window manager with a lean status bar — Nord themed, no dependencies beyond the two tools.

## What's included

| Path | Purpose |
|------|---------|
| `aerospace/aerospace.toml` | AeroSpace tiling WM config (hjkl focus/move, 6 workspaces) |
| `sketchybar/sketchybarrc` | Bar layout — workspaces, active app, battery, wifi, clock |
| `sketchybar/colors.sh` | Gruvbox color palette |
| `sketchybar/plugins/aerospace.sh` | Highlights focused workspace |
| `sketchybar/plugins/front_app.sh` | Shows active app name |
| `sketchybar/plugins/battery.sh` | Battery icon + percentage |
| `sketchybar/plugins/calendar.sh` | Date and time |
| `sketchybar/plugins/wifi.sh` | WiFi SSID + status |

## Requirements

```bash
brew install nikitabobko/tap/aerospace
brew install felixkratz/formulae/sketchybar
```

> Requires a [Nerd Font](https://www.nerdfonts.com) — the config uses **JetBrainsMono Nerd Font** for all bar text and icons. Install it with `brew install --cask font-jetbrains-mono-nerd-font`.

## Install

Clone and symlink the configs into place:

```bash
git clone https://github.com/ChrisTitusTech/aerospace-config.git ~/github/aerospace-config
cd ~/github/aerospace-config

# AeroSpace
mkdir -p ~/.config/aerospace
ln -sf "$PWD/aerospace/aerospace.toml" ~/.config/aerospace/aerospace.toml

# Sketchybar
mkdir -p ~/.config/sketchybar
ln -sf "$PWD/sketchybar/sketchybarrc"  ~/.config/sketchybar/sketchybarrc
ln -sf "$PWD/sketchybar/colors.sh"     ~/.config/sketchybar/colors.sh
ln -sf "$PWD/sketchybar/plugins"       ~/.config/sketchybar/plugins
```

Then start both services:

```bash
brew services start sketchybar
aerospace reload-config
```

## Key Bindings

| Key | Action |
|-----|--------|
| `Alt + h/j/k/l` | Focus window left/down/up/right |
| `Alt + Shift + h/j/k/l` | Move window |
| `Alt + 1-6` | Switch workspace |
| `Alt + Shift + 1-6` | Move window to workspace |
| `Alt + f` | Fullscreen |
| `Alt + Shift + Space` | Toggle floating |
| `Alt + e` | Tile layout |
| `Alt + s / w` | Accordion layout |
| `Alt + -/=` | Resize |
| `Alt + r` | Resize mode |
| `Alt + Tab` | Previous workspace |
| `Alt + Shift + c` | Reload config |

## Customization

- **Colors** — edit `sketchybar/colors.sh`. All plugins source it.
- **Workspaces** — the loop in `sketchybarrc` runs 1–6. Change the range to add/remove.
- **App assignments** — add `[[on-window-detected]]` blocks in `aerospace.toml`.

## License

MIT — see [LICENSE](LICENSE)
