# macOS 新机恢复（dotfiles）

目标：在新电脑上快速恢复常用配置与工具链，保持仓库路径固定为：

- `~/code/github.com/lianghx-319/dotfiles`

本仓库的核心入口：

- 依赖安装：`Brewfile`
- 配置链接：`startup.sh`

## 0. 前置条件

- 已登录 Apple ID（可选：用于 `mas` 安装 App Store 应用）
- 已有 Git（macOS 通常会提示安装 Command Line Tools）

## 1. 创建目录与克隆仓库

```bash
mkdir -p ~/code/github.com/lianghx-319
git clone https://github.com/lianghx-319/dotfiles ~/code/github.com/lianghx-319/dotfiles
cd ~/code/github.com/lianghx-319/dotfiles
```

## 2. 安装 Homebrew 并安装 Brewfile 里的软件

安装 Homebrew（若尚未安装）：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

按 `Brewfile` 安装：

```bash
brew bundle
```

检查是否齐全（可选）：

```bash
brew bundle check
```

## 3. 软链接配置文件到目标目录

在仓库根目录执行：

```bash
bash startup.sh
```

`startup.sh` 的行为：

- 把仓库内的配置软链接到 `~/.config/<name>`（以及少量 `~/Library/Application Support/...`）
- 目标存在时会自动备份为 `*.bak.<时间戳>`（symlink 会先 `unlink`）

## 4. 后置动作（需要人工完成）

### 4.1 fish

如需设为默认 shell：

```bash
chsh -s "$(which fish)"
```

### 4.2 tmux 插件（TPM）

- `tmux` 配置在 `~/.config/tmux/tmux.conf`
- 第一次进入 tmux 后按 `C-a` 再按 `I` 安装插件

### 4.3 neovim（NvChad + lazy.nvim）

首次启动 `nvim` 会自动拉取 `lazy.nvim` 与 `NvChad`，随后可执行一次：

- `:Lazy sync`

### 4.4 yabai / skhd（窗口管理）

安装后需要在 macOS「隐私与安全性」里授予相关权限（通常包括辅助功能/输入监控）。

启用为开机自启服务：

```bash
brew services start yabai
brew services start skhd
```

### 4.5 GPG / pass

详细的初始化步骤请参考：[Password Store 初始化指南](./password-store.md)

简要流程：
- 迁移你的 GPG 私钥与 `~/.password-store`
- 公钥示例（例如你的 `~/Downloads/public.pgp`）：

```bash
gpg --import ~/Downloads/public.pgp
```

## 5. 常见验证点

- `~/.config/fish`、`~/.config/tmux`、`~/.config/nvim` 等应为 symlink
- `brew bundle check` 通过
- `fish` / `tmux` / `nvim` 能正常启动
- 授权后，`skhd` 的快捷键能驱动 `yabai` 生效

