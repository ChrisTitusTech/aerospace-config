#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
AEROSPACE_DIR="$CONFIG_HOME/aerospace"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
INSTALL_MISSING=true

usage() {
  cat <<'EOF'
Usage: ./install.sh [--check-only]

Creates symlinks for AeroSpace config files.

Options:
  --check-only       Check dependencies but do not install missing packages
  -h, --help         Show this help message
EOF
}

log() {
  printf '[install] %s\n' "$1"
}

warn() {
  printf '[install] warning: %s\n' "$1" >&2
}

error() {
  printf '[install] error: %s\n' "$1" >&2
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

brew_formula_installed() {
  local formula="$1"
  brew list --formula "$formula" >/dev/null 2>&1
}

brew_cask_installed() {
  local cask="$1"
  brew list --cask "$cask" >/dev/null 2>&1
}

ensure_formula() {
  local formula="$1"
  local install_name="$2"

  if brew_formula_installed "$formula"; then
    log "Found formula: $formula"
    return
  fi

  if [[ "$INSTALL_MISSING" == true ]]; then
    log "Installing missing formula: $install_name"
    brew install "$install_name"
  else
    error "Missing Homebrew formula '$formula'. Install manually: brew install $install_name"
  fi
}

ensure_cask() {
  local cask="$1"

  if brew_cask_installed "$cask"; then
    log "Found cask: $cask"
    return
  fi

  if [[ "$INSTALL_MISSING" == true ]]; then
    log "Installing missing cask: $cask"
    brew install --cask "$cask"
  else
    error "Missing Homebrew cask '$cask'. Install manually: brew install --cask $cask"
  fi
}

check_prereqs() {
  [[ "$(uname -s)" == "Darwin" ]] || error "This installer only supports macOS."
  command_exists brew || error "Homebrew is required. Install from https://brew.sh"

  ensure_formula "aerospace" "nikitabobko/tap/aerospace"
  ensure_cask "font-jetbrains-mono-nerd-font"
}

check_settings() {
  log "Checking runtime settings"

  # AeroSpace without Accessibility/Automation permissions usually fails this call.
  if ! aerospace list-windows --workspace focused >/dev/null 2>&1; then
    warn "AeroSpace command is available but may not have required macOS permissions yet."
    warn "Open System Settings -> Privacy & Security and grant Accessibility + Automation to AeroSpace."
  else
    log "AeroSpace permissions look good."
  fi

  if ! pgrep -x Dock >/dev/null 2>&1; then
    warn "Dock process was not detected; Mission Control settings checks may be unreliable."
  fi
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

for arg in "$@"; do
  case "$arg" in
    --check-only)
      INSTALL_MISSING=false
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      error "Unknown argument: $arg"
      ;;
  esac
done

log "Using repo at $REPO_DIR"

check_prereqs
check_settings

mkdir -p "$AEROSPACE_DIR"

link_path "$REPO_DIR/aerospace/aerospace.toml" "$AEROSPACE_DIR/aerospace.toml"

log "Install complete."
log "Next steps:"
log "  1) aerospace reload-config"
