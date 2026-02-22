if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Setup brew
if test -d /home/linuxbrew/.linuxbrew
  /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
else if test -d /opt/homebrew
  /opt/homebrew/bin/brew shellenv | source
end

# Global bin PATH
set -px --path PATH "/usr/local/bin"
if not contains "$HOME/.cargo/bin" $PATH
    # Prepending path in case a system-installed rustc needs to be overridden
    set -px --path PATH "$HOME/.cargo/bin"
end

set -x LESS "-R"
set -x PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
set -x PUPPETEER_EXECUTABLE_PATH (which chromium)

if not contains "$HOME/.bun/bin" $PATH
    # Prepending path in case a system-installed rustc needs to be overridden
    set -px --path PATH "$HOME/.bun/bin"
end

#fnm --version-file-strategy recursive env --shell fish --use-on-cd | source
#fnm env --use-on-cd | source

# starship
if command -q starship
  starship init fish | source
end

# alias
if test -f ~/.config/fish/alias.fish
  source ~/.config/fish/alias.fish
end

# proxy
if test -f ~/.config/fish/plugins/proxy.fish
  source ~/.config/fish/plugins/proxy.fish
end

# 1password
if command -q op
  op completion fish | source
end

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# zoxide
if command -q zoxide
  zoxide init --cmd=cd fish | source
end

if test -f ~/.config/fish.local.fish
  source ~/.config/fish.local.fish
end

# Added by coco installer
fish_add_path /Users/bytedance/.local/bin

# OpenClaw Completion
if test -f ~/.openclaw/completions/openclaw.fish
  source ~/.openclaw/completions/openclaw.fish
end
