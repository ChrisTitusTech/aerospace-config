# aerospace-config

Minimal AeroSpace setup for macOS.

## Quick Start

1. Install dependencies:

```bash
brew install nikitabobko/tap/aerospace
brew install --cask font-jetbrains-mono-nerd-font
```

2. Clone this repo and run the installer:

```bash
git clone https://github.com/ChrisTitusTech/aerospace-config.git ~/github/aerospace-config
cd ~/github/aerospace-config
chmod +x install.sh
./install.sh
```

3. Reload AeroSpace:

```bash
aerospace reload-config
```

If AeroSpace is not managing windows yet, open macOS Settings and grant Accessibility and Automation permissions to AeroSpace.

## What This Repo Contains

| Path | Purpose |
|------|---------|
| `aerospace/aerospace.toml` | AeroSpace tiling WM config (hjkl focus/move, 8 workspaces, multi-monitor aware) |

## Installer Behavior

`install.sh` creates symlinks in `~/.config` and preserves local files by renaming them to `*.bak.<timestamp>` before linking.

It links:

- `~/.config/aerospace/aerospace.toml`

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
```

## Manual Install (Without Script)

```bash
mkdir -p ~/.config/aerospace

ln -sf "$PWD/aerospace/aerospace.toml" ~/.config/aerospace/aerospace.toml
```

## Configure It Quickly

Common changes most users make:

- Workspace count: update key bindings and persistent workspace values in `aerospace/aerospace.toml`.
- App workspace routing: edit the `[[on-window-detected]]` blocks in `aerospace/aerospace.toml`.

After any change:

```bash
aerospace reload-config
```

## Verify Installation

Run this check if something looks off:

```bash
aerospace config --all-keys >/dev/null && echo "AeroSpace config OK"
```

## License

MIT. See [LICENSE](LICENSE).
