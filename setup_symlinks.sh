#!/usr/bin/env bash
# Symlink dotfiles from this repo into $HOME on a new machine.
set -euo pipefail

DOTS="$(cd "$(dirname "${BASH_SOURCE[0]}")/home" && pwd)"

# source (relative to $DOTS) -> target (relative to $HOME)
declare -A LINKS=(
  [.gitconfig]=".gitconfig"
  [.tmux.conf]=".tmux.conf"
  [.vimrc]=".vimrc"
  [starship.toml]=".config/starship.toml"
)

for src in "${!LINKS[@]}"; do
  target="$HOME/${LINKS[$src]}"
  src_path="$DOTS/$src"

  if [ ! -e "$src_path" ]; then
    echo "skip: $src_path does not exist"
    continue
  fi

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$src_path" ]; then
    echo "ok:   $target already linked"
    continue
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    backup="${target}.bak.$(date +%Y%m%d%H%M%S)"
    echo "backup: $target -> $backup"
    mv "$target" "$backup"
  fi

  ln -s "$src_path" "$target"
  echo "linked: $target -> $src_path"
done
