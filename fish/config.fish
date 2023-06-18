if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Global bin PATH
set -px --path PATH "/opt/homebrew/bin"
set -px --path PATH "/usr/local/bin"
set -px --path PATH "$HOME/.cargo/bin"

# starship
starship init fish | source

# alias
if test -f ~/.config/fish/alias.fish
  source ~/.config/fish/alias.fish
end

# proxy
if test -f ~/.config/fish/plugins/proxy.fish
  source ~/.config/fish/plugins/proxy.fish
end

# 1password
op completion fish | source

