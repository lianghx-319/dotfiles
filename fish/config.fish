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
if test -f ./alias.fish
  source ./alias.fish
end

# proxy
if test -f ./plugins/proxy.fish
  source ./plugins/proxy.fish
end

# 1password
op completion fish | source

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
