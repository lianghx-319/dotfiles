#!/bin/bash

set -xe

symbol_link_config() {
    local dotfiles_location
    dotfiles_location="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    local config_location="$HOME/.config"
    local name="$1"
    local source="$dotfiles_location/$name"
    local default_target="${2-}"
    local target="${default_target:-$config_location/$name}"

    if [[ ! -e "$source" && ! -L "$source" ]]; then
        echo "source not found: $source" >&2
        return 1
    fi

    if [[ -L "$source" ]]; then
        echo "refusing symlink source: $source" >&2
        return 1
    fi

    mkdir -p "$(dirname "$target")"

    local source_dir_real
    local target_dir_real
    source_dir_real="$(cd "$(dirname "$source")" && pwd -P)"
    target_dir_real="$(cd "$(dirname "$target")" && pwd -P)"
    if [[ "$source_dir_real/$(basename "$source")" == "$target_dir_real/$(basename "$target")" ]]; then
        return 0
    fi

    if [[ -L "$target" ]]; then
        command unlink "$target"
    elif [[ -e "$target" ]]; then
        command mv "$target" "$target.bak.$(date +%Y%m%d%H%M%S)"
    fi

    command ln -sfn "$source" "$target"
}

configs=("fish" "alacritty" "tmux" "starship.toml" "nvim" "yabai" "skhd" "gnupg" "bat")

for name in "${configs[@]}"; do
    symbol_link_config "$name"
done

symbol_link_config "lazygit/config.yml" "$HOME/Library/Application Support/lazygit/config.yml"
symbol_link_config "ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
