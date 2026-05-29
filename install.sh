#!/bin/bash

echo "🚀 安装 mimo2codex++ ..."
echo ""

# 检查 Node.js 版本
if ! command -v node &> /dev/null; then
    echo "❌ 未找到 Node.js，请先安装 Node.js >= 22"
    echo "   下载地址: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 22 ]; then
    echo "❌ Node.js 版本过低，需要 >= 22，当前版本: $(node -v)"
    echo "   请升级 Node.js: https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js 版本: $(node -v)"

# 检查 pnpm
if ! command -v pnpm &> /dev/null; then
    echo "📦 安装 pnpm ..."
    npm install -g pnpm
fi

echo "✅ pnpm 版本: $(pnpm -v)"

# 安装依赖
echo ""
echo "📦 安装依赖 ..."
pnpm install

# 创建 .env.local
if [ ! -f .env.local ]; then
    cp .env.local.example .env.local
    echo "✅ 已创建 .env.local 配置文件"
fi

echo ""
echo "✅ 安装完成！"
echo ""
echo "启动命令："
echo "  pnpm dev"
echo ""
echo "然后打开浏览器访问: http://localhost:4020"
echo ""
