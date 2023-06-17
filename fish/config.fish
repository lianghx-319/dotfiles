if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Global bin PATH
set -px --path PATH "/opt/homebrew/bin"
set -px --path PATH "/usr/local/bin"
set -px --path PATH "$HOME/.cargo/bin"

# starship
starship init fish | source

# proxy
set proxy_host 192.168.2.4:7890
set proxy_auth false
set BAT_THEME "Catppuccin-macchiato"

# import all alias
source ~/.config/fish/alias.fish

# 1password
op completion fish | source

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
