# aerospace-config

Minimal AeroSpace + Sketchybar setup for macOS. Tiling window manager with a lean status bar, Nord themed.

## Quick Start

1. Install dependencies:

```bash
brew install nikitabobko/tap/aerospace
brew install felixkratz/formulae/sketchybar
brew install --cask font-jetbrains-mono-nerd-font
```

2. Clone this repo and run the installer:

```bash
git clone https://github.com/ChrisTitusTech/aerospace-config.git ~/github/aerospace-config
cd ~/github/aerospace-config
chmod +x install.sh
./install.sh
```

3. Start services:

```bash
brew services start sketchybar
aerospace reload-config
```

If AeroSpace is not managing windows yet, open macOS Settings and grant Accessibility and Automation permissions to AeroSpace.

## What This Repo Contains

| Path | Purpose |
|------|---------|
| `aerospace/aerospace.toml` | AeroSpace tiling WM config (hjkl focus/move, 8 workspaces, multi-monitor aware) |
| `sketchybar/sketchybarrc` | Bar layout — workspaces, active app, battery, wifi, clock |
| `sketchybar/colors.sh` | Nord color palette |
| `sketchybar/plugins/space.sh` | Highlights focused workspace |
| `sketchybar/plugins/front_app.sh` | Shows active app name |
| `sketchybar/plugins/battery.sh` | Battery icon + percentage |
| `sketchybar/plugins/calendar.sh` | Date and time |
| `sketchybar/plugins/wifi.sh` | Network online/offline status |

## Installer Behavior

`install.sh` creates symlinks in `~/.config` and preserves local files by renaming them to `*.bak.<timestamp>` before linking.

It links:

- `~/.config/aerospace/aerospace.toml`
- `~/.config/sketchybar/sketchybarrc`
- `~/.config/sketchybar/colors.sh`
- `~/.config/sketchybar/plugins`

## Uninstall

Use the uninstall script to remove symlinks created by this repo:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

To remove symlinks and restore the most recent backups created by `install.sh`:

```bash
./uninstall.sh --restore
```

`uninstall.sh` only removes symlinks that point to this repository and will not delete unrelated files.

## Rollback

If a config change causes issues, you have two rollback options:

1. Full rollback to the latest backups:

```bash
./uninstall.sh --restore
```

2. Manual rollback for a single file by swapping a backup back into place, for example:

```bash
mv ~/.config/aerospace/aerospace.toml.bak.<timestamp> ~/.config/aerospace/aerospace.toml
```

After rollback:

```bash
aerospace reload-config
brew services restart sketchybar
```

## Manual Install (Without Script)

```bash
mkdir -p ~/.config/aerospace ~/.config/sketchybar

ln -sf "$PWD/aerospace/aerospace.toml" ~/.config/aerospace/aerospace.toml
ln -sf "$PWD/sketchybar/sketchybarrc"  ~/.config/sketchybar/sketchybarrc
ln -sf "$PWD/sketchybar/colors.sh"     ~/.config/sketchybar/colors.sh
ln -sf "$PWD/sketchybar/plugins"       ~/.config/sketchybar/plugins
```

## Configure It Quickly

Common changes most users make:

- Colors: edit `sketchybar/colors.sh`.
- Workspace count: update both `aerospace/aerospace.toml` (workspace bindings + `[workspace-to-monitor-force-assignment]`) and `sketchybar/sketchybarrc` (workspace loop).
- App workspace routing: edit the `[[on-window-detected]]` blocks in `aerospace/aerospace.toml`.
- Bar modules: add or remove items in `sketchybar/sketchybarrc`.

After any change:

```bash
aerospace reload-config
brew services restart sketchybar
```

## Key Bindings

### Window Focus

| Key | Action |
|-----|--------|
| `Alt + h` | Focus window left |
| `Alt + j` | Focus window down |
| `Alt + k` | Focus window up |
| `Alt + l` | Focus window right |

### Window Movement

| Key | Action |
|-----|--------|
| `Alt + Shift + h` | Move window left |
| `Alt + Shift + j` | Move window down |
| `Alt + Shift + k` | Move window up |
| `Alt + Shift + l` | Move window right |

### Layout

| Key | Action |
|-----|--------|
| `Alt + e` | Toggle tile layout (horizontal / vertical) |
| `Alt + s` | Vertical accordion layout |
| `Alt + w` | Horizontal accordion layout |
| `Alt + g` | Split horizontal |
| `Alt + v` | Split vertical |
| `Alt + f` | AeroSpace fullscreen |
| `Alt + Shift + f` | macOS native fullscreen |
| `Alt + Shift + Space` | Toggle floating / tiling |

### Resize

| Key | Action |
|-----|--------|
| `Alt + -` | Shrink window |
| `Alt + =` | Grow window |
| `Alt + r` | Enter resize mode |

**Resize mode** (`Alt + r`, then):

| Key | Action |
|-----|--------|
| `h` | Decrease width |
| `j` | Increase height |
| `k` | Decrease height |
| `l` | Increase width |
| `Enter` / `Esc` | Exit resize mode |

### Workspaces

| Key | Action |
|-----|--------|
| `Alt + 1–8` | Switch to workspace 1–8 |
| `Alt + Shift + 1–8` | Move window to workspace 1–8 |
| `Alt + Tab` | Toggle previous workspace |
| `Alt + Shift + Tab` | Move workspace to next monitor |

### Multi-Monitor

| Key | Action |
|-----|--------|
| `Alt + Ctrl + h` | Focus monitor left |
| `Alt + Ctrl + l` | Focus monitor right |
| `Alt + Ctrl + Shift + h` | Move window to monitor left |
| `Alt + Ctrl + Shift + l` | Move window to monitor right |

### Misc

| Key | Action |
|-----|--------|
| `Alt + Enter` | Open Terminal |
| `Alt + Shift + c` | Reload AeroSpace config |
| `Alt + Shift + ;` | Enter service mode |

### Service Mode

Enter with `Alt + Shift + ;`, exit with `Esc`.

| Key | Action |
|-----|--------|
| `r` | Flatten / reset workspace layout |
| `f` | Toggle floating / tiling |
| `Backspace` | Close all windows except current |
| `Alt + Shift + h` | Join with window to the left |
| `Alt + Shift + j` | Join with window below |
| `Alt + Shift + k` | Join with window above |
| `Alt + Shift + l` | Join with window to the right |
| `Esc` | Return to main mode |

## Multi-Monitor Workspace Layout

Workspaces are automatically distributed across connected monitors. When fewer monitors are connected, workspaces fall back to the next available monitor.

| Workspaces | 1 Monitor | 2 Monitors | 3 Monitors |
|------------|-----------|------------|------------|
| 1 – 4 | Monitor 1 | Monitor 1 | Monitor 1 |
| 5 – 6 | Monitor 1 | Monitor 2 | Monitor 2 |
| 7 – 8 | Monitor 1 | Monitor 2 | Monitor 3 |

To adjust the distribution, edit the `[workspace-to-monitor-force-assignment]` block in `aerospace/aerospace.toml`.

## Verify Installation

Run these checks if something looks off:

```bash
aerospace config --all-keys >/dev/null && echo "AeroSpace config OK"
sketchybar --reload
```

## License

MIT. See [LICENSE](LICENSE).
