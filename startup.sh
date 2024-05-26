#!/bin/bash

set -xe

symbol_link_config() {
    local dotfiles_location=~/code/github.com/lianghx-319/dotfiles
    local config_loaction=~/.config
    local name=$1
    local source=$dotfiles_location/$name
    local target=$config_loaction/$name
    ln -sf $source $target
}

configs=("fish" "alacritty" "tmux" "starship.toml" "nvim" "yabai" "skhd" "gunpg" "bat" "lazygit")

for name in ${configs[@]}; do
    symbol_link_config $name
done
