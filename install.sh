#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
AEROSPACE_DIR="$CONFIG_HOME/aerospace"
SKETCHYBAR_DIR="$CONFIG_HOME/sketchybar"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

log() {
  printf '[install] %s\n' "$1"
}

backup_if_needed() {
  local target="$1"

  if [[ -e "$target" && ! -L "$target" ]]; then
    local backup_path="${target}.bak.${TIMESTAMP}"
    mv "$target" "$backup_path"
    log "Backed up existing file: $target -> $backup_path"
  fi
}

link_path() {
  local source_path="$1"
  local target_path="$2"

  backup_if_needed "$target_path"
  ln -sfn "$source_path" "$target_path"
  log "Linked $target_path -> $source_path"
}

log "Using repo at $REPO_DIR"

mkdir -p "$AEROSPACE_DIR" "$SKETCHYBAR_DIR"

link_path "$REPO_DIR/aerospace/aerospace.toml" "$AEROSPACE_DIR/aerospace.toml"
link_path "$REPO_DIR/sketchybar/sketchybarrc" "$SKETCHYBAR_DIR/sketchybarrc"
link_path "$REPO_DIR/sketchybar/colors.sh" "$SKETCHYBAR_DIR/colors.sh"
link_path "$REPO_DIR/sketchybar/plugins" "$SKETCHYBAR_DIR/plugins"

log "Install complete."
log "Next steps:"
log "  1) brew services start sketchybar"
log "  2) aerospace reload-config"
