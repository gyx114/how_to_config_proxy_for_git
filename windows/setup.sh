#!/bin/bash

# 创建脚本目录
mkdir -p ~/scripts

# 创建开启代理脚本
cat > ~/scripts/proxy_on << 'EOF'
#!/bin/bash
git config --global http.proxy http://127.0.0.1:21882
git config --global https.proxy http://127.0.0.1:21882
echo "✅ Git 代理已开启"
EOF

# 创建关闭代理脚本
cat > ~/scripts/proxy_off << 'EOF'
#!/bin/bash
git config --global --unset http.proxy
git config --global --unset https.proxy
echo "✅ Git 代理已关闭"
EOF

# 添加执行权限
chmod +x ~/scripts/proxy_on ~/scripts/proxy_off

# 添加到 PATH
if ! grep -q 'export PATH="$HOME/scripts:$PATH"' ~/.bashrc; then
    echo 'export PATH="$HOME/scripts:$PATH"' >> ~/.bashrc
fi

source ~/.bashrc

echo "✅ Windows Git 代理配置完成！"
echo "使用方法：proxy_on  /  proxy_off"
