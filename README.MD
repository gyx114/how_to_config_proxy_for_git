# Git 代理配置指南

解决 WSL 和 Windows 下 Git/SSH 走代理的问题。

## 前置条件

- 代理软件已开启，HTTP 代理端口：`21882`
- Windows 10/11 + WSL2

## 协议说明
- **Windows**: 使用HTTP/HTTPS协议，配置git代理
- **WSL**: 使用SSH协议，通过ProxyCommand走代理

## 快速安装

### Windows (Git Bash)

```bash
cd windows
./setup.sh
```

### WSL

```bash
cd wsl
./setup.sh
```

## 使用

| 环境 | 开启代理 | 关闭代理 |
| --- | --- | --- |
| Windows (Git Bash) | `proxy_on` | `proxy_off` |
| WSL | `proxy_on` | `proxy_off` |

## WSL 镜像模式配置

必须先配置镜像模式，否则 WSL 无法使用代理。

1. 将 `wsl-mirror/.wslconfig` 复制到 Windows 用户目录：

```bash
cp wsl-mirror/.wslconfig ~/.wslconfig
```

2. 重启 WSL：

```bash
wsl --shutdown
```

3. 重新打开 WSL 终端。

## 代理端口说明

- HTTP 代理端口：`21882`
- 如需修改，编辑脚本中的端口号
