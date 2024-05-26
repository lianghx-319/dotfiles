#!/bin/bash

set -xe

symbol_link_config() {
    local dotfiles_location=~/code/github.com/lianghx-319/dotfiles
    local config_loaction=~/.config
    local name=$1
    local source=$dotfiles_location/$name
    local default_target=$2
    local target=${default_target:="$config_loaction/$name"}
    unlink $target
    ln -s $source $target
}

configs=("fish" "alacritty" "tmux" "starship.toml" "nvim" "yabai" "skhd" "gunpg" "bat")

for name in ${configs[@]}; do
    symbol_link_config $name
done

# FIXME: path with space not working
symbol_link_config "lazygit/config.yml" "~/Library/Application\ Support/lazygit/config.yml"
