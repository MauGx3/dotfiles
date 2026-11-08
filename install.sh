#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

should_skip() {
  case "$1" in
    "."|".."|".git"|".github")
      return 0
      ;;
    "install"|"install.sh"|"bootstrap"|"bootstrap.sh"|"setup"|"setup.sh")
      return 0
      ;;
  esac
  return 1
}

link_item() {
  local source_path="$1"
  local target_path="$HOME/$2"

  if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
    echo "Already linked: $target_path"
    return
  fi

  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    local backup_path="$target_path.backup.$(date +%Y%m%d%H%M%S)"
    mv "$target_path" "$backup_path"
    echo "Backed up existing: $target_path -> $backup_path"
  fi

  ln -s "$source_path" "$target_path"
  echo "Linked: $target_path -> $source_path"
}

for path in "$DOTFILES_DIR"/.*; do
  name="$(basename "$path")"

  if should_skip "$name"; then
    continue
  fi

  link_item "$path" "$name"
done

echo "Dotfiles setup complete."
