if status is-interactive
    # Commands to run in interactive sessions can go here
end

# proxy
set proxy_host 192.168.2.4:7890
set proxy_auth false
set BAT_THEME "Catppuccin-macchiato"

# starship
starship init fish | source

# import all alias
source ~/.config/fish/alias.fish

# Rust
set -px --path PATH "$HOME/.cargo/bin"

# Load lvim
set -px --path PATH "$HOME/.local/bin"

# 1password
set -px --path PATH "/usr/local/bin"
op completion fish | source

