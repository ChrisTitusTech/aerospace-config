#!/usr/bin/env bash

set -euo pipefail

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
AEROSPACE_DIR="$CONFIG_HOME/aerospace"
RESTORE=false

usage() {
  cat <<'EOF'
Usage: ./uninstall.sh [--restore]

Removes symlinks created by install.sh:
  ~/.config/aerospace/aerospace.toml

Options:
  --restore   Restore most recent *.bak.* backups if available
  -h, --help  Show this help message
EOF
}

log() {
  printf '[uninstall] %s\n' "$1"
}

is_our_symlink() {
  local path="$1"
  local expected_suffix="$2"

  [[ -L "$path" ]] || return 1
  local target
  target="$(readlink "$path")"
  [[ "$target" == *"$expected_suffix" ]]
}

remove_link_if_ours() {
  local path="$1"
  local expected_suffix="$2"

  if is_our_symlink "$path" "$expected_suffix"; then
    rm "$path"
    log "Removed symlink: $path"
  elif [[ -L "$path" ]]; then
    log "Skipped symlink not owned by this repo: $path"
  elif [[ -e "$path" ]]; then
    log "Skipped regular file/dir (not a symlink): $path"
  else
    log "Nothing to remove: $path"
  fi
}

restore_latest_backup() {
  local original_path="$1"
  local parent_dir
  parent_dir="$(dirname "$original_path")"
  local base_name
  base_name="$(basename "$original_path")"

  local latest_backup
  latest_backup="$(ls -1t "$parent_dir/$base_name".bak.* 2>/dev/null | head -n 1 || true)"

  if [[ -z "$latest_backup" ]]; then
    log "No backup found for $original_path"
    return
  fi

  if [[ -e "$original_path" || -L "$original_path" ]]; then
    rm -rf "$original_path"
  fi

  mv "$latest_backup" "$original_path"
  log "Restored backup: $latest_backup -> $original_path"
}

for arg in "$@"; do
  case "$arg" in
    --restore)
      RESTORE=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $arg" >&2
      usage
      exit 1
      ;;
  esac
done

remove_link_if_ours "$AEROSPACE_DIR/aerospace.toml" "/aerospace/aerospace.toml"

if [[ "$RESTORE" == true ]]; then
  log "Restoring latest backups when available..."
  restore_latest_backup "$AEROSPACE_DIR/aerospace.toml"
fi

log "Uninstall complete."
