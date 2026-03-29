# Password Store (pass) 初始化指南

本指南介绍如何在一部新电脑上初始化 `password-store` (pass) 环境。

## 1. 安装必要软件

确保你已经按照 [bootstrap-macos.md](./bootstrap-macos.md) 运行了 `brew bundle`。主要涉及以下工具：

- `gnupg`: GPG 密钥管理
- `pass`: 密码管理器本体
- `pinentry-mac`: (推荐) macOS 下的 GPG 密码输入弹窗（避免在无 TTY 场景解密失败）

## 2. 导入 GPG 密钥

你需要将旧电脑上的 GPG 私钥迁移过来。

### 导出（在旧电脑上）

```bash
# 查看密钥 ID
gpg --list-secret-keys

# 导出私钥 (替换 <KEY_ID>)
gpg --export-secret-keys <KEY_ID> > my-private-key.asc
# 导出公钥
gpg --export <KEY_ID> > my-public-key.asc
```

### 导入（在新电脑上）

```bash
gpg --import my-public-key.asc
gpg --import my-private-key.asc
```

### 信任密钥

导入后，你需要手动信任该密钥，否则 `pass` 在加解密时可能会报错。

1. 进入交互式编辑模式：
   ```bash
   gpg --edit-key <KEY_ID>
   ```
2. 输入 `trust`
3. 选择 `5` (I trust ultimately)
4. 输入 `y` 确认
5. 输入 `quit` 退出

## 3. 克隆 Password Store 仓库

`pass` 默认使用 `~/.password-store` 目录。如果你的密码库托管在 Git 仓库（如私有 GitHub/GitLab），直接克隆即可：

```bash
git clone git@github.com:your-username/your-pass-repo.git ~/.password-store
```

如果你只是手动同步目录，请确保目录结构正确：

```bash
mkdir ~/.password-store
# 然后将备份的 .gpg 文件和 .gpg-id 拷贝进去
```

## 4. 配置 GPG Agent (可选)

为了避免频繁输入 GPG 密码，可以配置 `gpg-agent`。本仓库已提供 [gpg-agent.conf](../gnupg/gpg-agent.conf)，通过 `startup.sh` 会自动链接到 `~/.gnupg/gpg-agent.conf`。

如果需要手动配置，确保 `~/.gnupg/gpg-agent.conf` 包含：

```text
max-cache-ttl 34560000
default-cache-ttl 34560000
# macOS 建议添加（Apple Silicon 通常为 /opt/homebrew；Intel 通常为 /usr/local）
pinentry-program /opt/homebrew/bin/pinentry-mac
```

修改配置后重启 agent：

```bash
gpgconf --kill gpg-agent
```

## 5. 验证

尝试读取一个密码：

```bash
pass <some/password/path>
```

如果能正常解密并显示，说明初始化成功。

## 6. GitHub 鉴权（Git Credential Manager + pass）

如果你使用 HTTPS remote（如 `https://github.com/...`），推荐用 Git Credential Manager（GCM）做 OAuth/PAT 登录，并把 token 加密落盘到 `pass`（`~/.password-store`）。

### 6.1 一键修复/启用（可独立运行）

适用场景：机器已经装好大部分环境，但 `git push` 反复提示登录、或 GCM 报错无法读写 `pass`。

```bash
set -euo pipefail

# 1) pinentry（解决“无 TTY 场景”下 gpg 解密/加密失败）
if command -v brew >/dev/null 2>&1; then
  brew list --formula pinentry-mac >/dev/null 2>&1 || brew install pinentry-mac
fi

PINENTRY_BIN="$(command -v pinentry-mac || true)"
if [ -z "$PINENTRY_BIN" ]; then
  echo "pinentry-mac not found; please install it first" >&2
  exit 1
fi

mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"

GPG_AGENT_CONF="$HOME/.gnupg/gpg-agent.conf"
if [ ! -f "$GPG_AGENT_CONF" ]; then
  cat >"$GPG_AGENT_CONF" <<EOF
max-cache-ttl 34560000
default-cache-ttl 34560000

# macOS：使用 GUI pinentry，避免在无 TTY 场景（IDE/GUI Git）解密失败
pinentry-program $PINENTRY_BIN
EOF
else
  # 不覆盖已有配置，仅保证 pinentry-program 存在
  if ! grep -q '^pinentry-program ' "$GPG_AGENT_CONF"; then
    printf '\n# macOS：使用 GUI pinentry，避免在无 TTY 场景（IDE/GUI Git）解密失败\n' >>"$GPG_AGENT_CONF"
    printf 'pinentry-program %s\n' "$PINENTRY_BIN" >>"$GPG_AGENT_CONF"
  fi
fi
chmod 600 "$GPG_AGENT_CONF"

gpgconf --kill gpg-agent >/dev/null 2>&1 || true
gpgconf --launch gpg-agent >/dev/null 2>&1 || true

# 2) 信任 pass 的收件人 key（解决：There is no assurance this key belongs... / Unusable public key）
if [ -f "$HOME/.password-store/.gpg-id" ]; then
  PASS_FPR="$(head -n1 "$HOME/.password-store/.gpg-id" | tr -d ' \t\r')"
  if [ -n "$PASS_FPR" ]; then
    echo "$PASS_FPR:6:" | gpg --import-ownertrust >/dev/null
  fi
fi

# 3) 配置 GitHub 使用 GCM，并让 GCM 使用 gpg 存储（pass backend）
GCM_BIN="$(command -v git-credential-manager || true)"
if [ -z "$GCM_BIN" ]; then
  echo "git-credential-manager not found; please install it first" >&2
  exit 1
fi

git config --global includeIf.gitdir:~/code/github.com/.path "$HOME/.github.gitconfig"

if [ ! -f "$HOME/.github.gitconfig" ]; then
  cat >"$HOME/.github.gitconfig" <<EOF
# GitHub 专用配置（被 ~/.gitconfig 的 includeIf 引入）

[credential]
    useHttpPath = true
    credentialStore = gpg

[credential "https://github.com"]
    # 禁用系统 keychain，避免残留旧凭据导致反复提示登录
    helper =
    helper = $GCM_BIN
EOF
fi

# 4) 验证（不应提示输入用户名/密码）
git-credential-manager github list >/dev/null
echo "GCM + pass for GitHub: OK"
```

### 6.2 常见报错速查

- `gpg: public key decryption failed: Inappropriate ioctl for device`
  - 多见于没有配置 `pinentry-mac`（IDE/GUI Git 没有 TTY），按上面的 6.1 修复。
- `There is no assurance this key belongs to the named user` / `Unusable public key`
  - key 未设置信任（`[ unknown]`），需要设置 ownertrust（6.1 已包含）。
- `git push` 反复弹 "GitHub select account" OAuth 授权窗口
  - 原因：macOS Keychain 里缓存了过期的 GitHub OAuth token（来自旧 `gh` 或其他工具），GCM 优先读取了 Keychain 而非 pass 中的 PAT，导致认证失败后 fallback 到 OAuth 流程。
  - 解决：清除 Keychain 中的 GitHub 相关凭据，或卸载 `gh`（`brew uninstall gh`），然后重新执行 `git-credential-manager github login` 刷新 token。
