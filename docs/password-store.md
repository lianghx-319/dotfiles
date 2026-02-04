# Password Store (pass) 初始化指南

本指南介绍如何在一部新电脑上初始化 `password-store` (pass) 环境。

## 1. 安装必要软件

确保你已经按照 [bootstrap-macos.md](./bootstrap-macos.md) 运行了 `brew bundle`。主要涉及以下工具：

- `gnupg`: GPG 密钥管理
- `pass`: 密码管理器本体
- `pinentry-mac`: (可选) macOS 下的 GPG 密码输入弹窗

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
# macOS 建议添加
pinentry-program /usr/local/bin/pinentry-mac
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
