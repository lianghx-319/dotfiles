#!/usr/bin/env bash

set -euo pipefail

DOTFILES_REPO_URL="${DOTFILES_REPO_URL:-https://github.com/lianghx-319/dotfiles}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/code/github.com/lianghx-319/dotfiles}"

ensure_dir() {
  mkdir -p "$1"
}

is_git_repo() {
  git -C "$1" rev-parse --is-inside-work-tree >/dev/null 2>&1
}

print_step() {
  printf "\n==> %s\n" "$1"
}

print_step "准备 dotfiles 目录"
ensure_dir "$(dirname "$DOTFILES_DIR")"

if [[ -d "$DOTFILES_DIR" ]] && is_git_repo "$DOTFILES_DIR"; then
  :
elif [[ -d "$DOTFILES_DIR" ]] && [[ ! -e "$DOTFILES_DIR/.git" ]]; then
  printf "目标目录已存在但不是 git 仓库：%s\n" "$DOTFILES_DIR" >&2
  printf "请手动清理或设置 DOTFILES_DIR 指向正确路径后重试。\n" >&2
  exit 2
else
  print_step "克隆 dotfiles"
  git clone "$DOTFILES_REPO_URL" "$DOTFILES_DIR"
fi

print_step "检测并安装 Homebrew（如需要）"
if command -v brew >/dev/null 2>&1; then
  :
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

print_step "按 Brewfile 安装依赖"
brew bundle --file "$DOTFILES_DIR/Brewfile" --no-lock

print_step "链接配置文件（startup.sh）"
bash "$DOTFILES_DIR/startup.sh"

print_step "后置动作提示"
cat <<'EOF'
1) fish（可选设为默认）
   chsh -s "$(which fish)"

2) tmux 插件
   进入 tmux 后按：C-a 然后 I

3) neovim
   首次启动后可执行：:Lazy sync

4) yabai / skhd
   需要在 macOS「隐私与安全性」里授予相关权限（通常包括辅助功能/输入监控）。
   启用为服务：
     brew services start yabai
     brew services start skhd

5) mas（App Store 安装）
   需先登录 Apple ID；之后可再次运行：
     brew bundle --file "$HOME/code/github.com/lianghx-319/dotfiles/Brewfile" --no-lock
EOF

