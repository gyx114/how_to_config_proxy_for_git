#!/bin/bash

# 创建脚本目录
mkdir -p ~/scripts

# 创建开启代理脚本
cat > ~/scripts/proxy_on << 'EOF'
#!/bin/bash
sed -i 's/^[[:space:]]*#ProxyCommand/        ProxyCommand/' ~/.ssh/config
echo "✅ SSH 代理已开启"
EOF

# 创建关闭代理脚本
cat > ~/scripts/proxy_off << 'EOF'
#!/bin/bash
sed -i 's/^[[:space:]]*ProxyCommand/        #ProxyCommand/' ~/.ssh/config
echo "✅ SSH 代理已关闭"
EOF

# 添加执行权限
chmod +x ~/scripts/proxy_on ~/scripts/proxy_off

# 添加到 PATH
if ! grep -q 'export PATH="$HOME/scripts:$PATH"' ~/.bashrc; then
    echo 'export PATH="$HOME/scripts:$PATH"' >> ~/.bashrc
fi

# 配置 SSH config（如果不存在）
if [ ! -f ~/.ssh/config ]; then
    mkdir -p ~/.ssh
    cat > ~/.ssh/config << 'EOF'
Host github.com github
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa
    IdentitiesOnly yes
    StrictHostKeyChecking accept-new
    ProxyCommand nc -X connect -x localhost:21882 %h %p
EOF
    echo "✅ SSH config 已创建"
else
    echo "⚠️ SSH config 已存在，请确保包含以下配置："
    echo ""
    echo "Host github.com github"
    echo "    HostName github.com"
    echo "    User git"
    echo "    ProxyCommand nc -X connect -x localhost:21882 %h %p"
fi

source ~/.bashrc

echo "✅ WSL SSH 代理配置完成！"
echo "使用方法：proxy_on  /  proxy_off"
