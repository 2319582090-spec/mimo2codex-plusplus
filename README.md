<div align="center">

# mimo2codex++

### 🚀 多账号 MiMo 网关 + 额度看板

**通过多账号并发突破单账号并发上限，彻底解决 429 限流问题**

[![GitHub Stars](https://img.shields.io/github/stars/2319582090-spec/mimo2codex-plusplus?style=social)](https://github.com/2319582090-spec/mimo2codex-plusplus/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/2319582090-spec/mimo2codex-plusplus?style=social)](https://github.com/2319582090-spec/mimo2codex-plusplus/network/members)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Node](https://img.shields.io/badge/node-%3E%3D22-green.svg)](https://nodejs.org/)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Windows%20%7C%20Linux-lightgrey.svg)]()

[English](#english) · [快速开始](#-快速开始) · [功能特性](#-功能特性) · [常见问题](#-常见问题) · [联系方式](#-联系方式)

</div>

---

## 📖 这是什么？

**mimo2codex++** 是一个本地代理网关，让你可以同时使用**多个小米 MiMo API Key**，通过智能调度实现：

- ✅ **突破并发上限** — 2 个账号 = 2 倍并发
- ✅ **自动 429 避让** — 一个被限流，自动切换到另一个
- ✅ **额度可视化** — 实时看到每个账号的使用情况
- ✅ **一键配置** — 自动生成 Codex 配置，复制即用

### 为什么需要它？

| 场景 | 单账号 | mimo2codex++ (2 账号) |
|------|--------|----------------------|
| 并发上限 | 20 | **40** |
| RPM | 500 | **1000** |
| TPM | 100K | **200K** |
| 429 风险 | 高 | **低** |

> 💡 **简单来说：** 如果你经常遇到 429 错误，或者需要更高的并发能力，这个项目就是为你准备的。

---

## 🚀 快速开始

### 前置条件

- [Node.js](https://nodejs.org/) >= 22
- [pnpm](https://pnpm.io/)（如果没有会自动安装）
- [mimo2codex](https://github.com/7as0nch/mimo2codex)（核心代理）

### 安装步骤

```bash
# 1. 克隆仓库
git clone https://github.com/2319582090-spec/mimo2codex-plusplus.git
cd mimo2codex-plusplus

# 2. 运行安装脚本
chmod +x install.sh
./install.sh

# 3. 启动服务
pnpm dev
```

### 访问 Dashboard

打开浏览器访问：**http://localhost:4020**

---

## ✨ 功能特性

### 🔄 多账号并发调度

- 每个 Key 对应一个 mimo2codex 实例
- 智能负载均衡（Health-weighted round robin）
- 自动故障转移

### 🛡️ 429 智能避让

- 遇到 429 自动切换到其他账号
- 冷却期结束后自动恢复
- 无需手动干预

### 📊 额度看板

- 实时显示每个 Key 的状态
- 请求统计（成功/失败/429）
- 冷却状态和恢复时间

### ⚙️ 一键配置

- 自动生成 Codex `auth.json` 和 `config.toml`
- 一键复制到剪贴板
- 支持自定义 Gateway URL

### 🔒 安全存储

- API Key 使用 AES-256-GCM 加密
- 仅存储在本地，不会上传到任何服务器
- 前端仅显示 Key 的前缀和后缀

### 🖥️ 开机自启 (macOS)

```bash
# 设置开机自启
./scripts/service.sh start

# 查看状态
./scripts/service.sh status

# 停止服务
./scripts/service.sh stop
```

---

## 📊 小米 MiMo 并发限制

### 套餐并发上限

| 套餐 | 价格 | 并发上限 |
|------|------|----------|
| **Lite** | 39 元/月 | 5 并发 |
| **Standard** | 99 元/月 | 20 并发 |
| **Pro** | 329 元/月 | 不设上限* |
| **Max** | 659 元/月 | 不设上限* |

*受 TPM 与集群负载约束

### API 速率限制（所有套餐）

| 限制类型 | 默认值 |
|----------|--------|
| RPM（每分钟请求数） | 500 |
| TPM（每分钟 Token 数） | 100,000 |

### mimo2codex++ 如何突破？

**示例：** 3 个 Standard 套餐账号

| 指标 | 单账号 | 3 账号并发 | 提升 |
|------|--------|-----------|------|
| 并发上限 | 20 | 60 | **3x** |
| RPM | 500 | 1500 | **3x** |
| TPM | 100K | 300K | **3x** |

---

## 🏗️ 技术架构

```
┌─────────────────────────────────────────────────────────┐
│                    mimo2codex++                          │
├─────────────────────────────────────────────────────────┤
│  ┌─────────┐  ┌─────────┐  ┌─────────┐                 │
│  │ Key 1   │  │ Key 2   │  │ Key N   │  ← API Keys     │
│  └────┬────┘  └────┬────┘  └────┬────┘                 │
│       │            │            │                        │
│  ┌────▼────┐  ┌────▼────┐  ┌────▼────┐                 │
│  │Instance1│  │Instance2│  │InstanceN│  ← mimo2codex   │
│  │ :9100   │  │ :9101   │  │ :91XX   │    实例          │
│  └────┬────┘  └────┬────┘  └────┬────┘                 │
│       │            │            │                        │
│       └────────────┼────────────┘                        │
│                    │                                     │
│            ┌───────▼───────┐                             │
│            │  Pool Manager │  ← 智能调度                │
│            │  - 健康检查    │                             │
│            │  - 负载均衡    │                             │
│            │  - 429 避让   │                             │
│            └───────┬───────┘                             │
│                    │                                     │
│            ┌───────▼───────┐                             │
│            │   Gateway     │  ← 统一入口                │
│            │  :4020/v1     │                             │
│            └───────┬───────┘                             │
└────────────────────┼────────────────────────────────────┘
                     │
              ┌──────▼──────┐
              │    Codex    │
              └─────────────┘
```

---

## 📁 项目结构

```
mimo2codex-plusplus/
├── src/
│   ├── app/
│   │   ├── api/
│   │   │   ├── keys/          # Key 管理 API
│   │   │   ├── pool/          # 实例池管理 API
│   │   │   └── codex/         # Codex 配置生成
│   │   ├── v1/                # 统一网关入口
│   │   ├── page.tsx           # Dashboard 页面
│   │   └── layout.tsx         # 布局
│   └── lib/
│       ├── encryption.ts      # AES-256-GCM 加密
│       ├── key-store.ts       # Key 持久化
│       ├── pool-manager.ts    # 实例池管理
│       ├── quota-client.ts    # 额度查询
│       └── types.ts           # 类型定义
├── images/                    # 文档截图
├── scripts/
│   └── service.sh             # macOS 服务管理脚本
├── install.sh                 # 一键安装脚本
├── package.json
└── README.md
```

---

## 🔧 配置说明

### 环境变量

创建 `.env.local` 文件：

```bash
# 服务端口（默认 4020）
PORT=4020

# 日志级别
LOG_LEVEL=info
```

### Codex 配置

在 Dashboard 的 "Codex 接入" 页面生成配置，或手动创建：

**auth.json:**
```json
{
  "OPENAI_API_KEY": "mimo2codexplusplus-local"
}
```

**config.toml:**
```toml
model = "mimo-v2.5-pro"
model_provider = "mimo"
model_context_window = 1000000
model_max_output_tokens = 131072

[model_providers.mimo]
name = "mimo2codex++ gateway"
base_url = "http://127.0.0.1:4020/v1"
wire_api = "responses"
requires_openai_auth = true
```

---

## ❓ 常见问题

### Q: 启动后无法访问？
A: 检查端口 4020 是否被占用：`lsof -i :4020`

### Q: 实例状态一直是 "starting"？
A: 检查 mimo2codex 是否安装：`which mimo2codex`

### Q: 如何添加更多 Key？
A: 在 Dashboard 的 "账号池" 页面点击 "添加 Key"

### Q: 支持哪些平台？
A: macOS、Windows、Linux（需要 Node.js >= 22）

### Q: 会消耗更多额度吗？
A: 是的，多账号并发会更快消耗上游额度。这是"提升并发上限"的代价。

---

## 🤝 参与贡献

欢迎提交 Issue 和 Pull Request！

```bash
# 克隆仓库
git clone https://github.com/2319582090-spec/mimo2codex-plusplus.git
cd mimo2codex-plusplus

# 安装依赖
pnpm install

# 启动开发服务器
pnpm dev

# 运行类型检查
pnpm typecheck

# 运行 lint
pnpm lint
```

---

## 📄 开源协议

MIT License - 详见 [LICENSE](LICENSE)

---

## 🙏 致谢

- [mimo2codex](https://github.com/7as0nch/mimo2codex) - 核心代理能力
- [Next.js](https://nextjs.org/) - Web 框架
- [Tailwind CSS](https://tailwindcss.com/) - 样式框架

---

## 📞 联系方式

- **邮箱：** 2319582090@qq.com
- **邮箱：** 2319582090z@gmail.com
- **GitHub Issues：** [提交问题](https://github.com/2319582090-spec/mimo2codex-plusplus/issues)

---

## ⭐ 支持项目

如果这个项目对你有帮助，欢迎赞赏支持！

![赞赏支持](images/donate.jpg)

也可以给个 **Star** ⭐ 让更多人看到！

---

## 📸 效果展示

### Dashboard 看板

![Dashboard](images/dashboard.png)

### 429 错误解决

![429 错误](images/429-error.jpeg)

### 多账号并发

![多账号并发](images/multi-account.png)

---

<div align="center">

**mimo2codex++** — 让多账号并发不再受限，让 429 错误成为历史。

Made with ❤️ by [2319582090-spec](https://github.com/2319582090-spec)

</div>
