# mimo2codex++

**多账号 MiMo 网关 + 额度看板** — 通过多账号并发突破单账号并发上限，解决 429 限流问题。

> Display name: **mimo2codex++**  
> npm / folder naming: **mimo2codex-plusplus**

---

## 🎯 为什么需要 mimo2codex++？

使用单个小米 Key 时，经常遇到 `429 Too Many Requests` 错误，任务频繁失败。原因是单账号存在并发和速率限制。

### 小米套餐并发上限

| 套餐 | 并发上限 |
|------|----------|
| Lite（39 元） | 5 并发 |
| Standard（99 元） | 20 并发 |
| Pro/Max（329/659 元） | 不设上限* |

*受 TPM 与集群负载约束

### API 速率限制（所有套餐）

| 限制类型 | 默认值 |
|----------|--------|
| RPM（每分钟请求数） | 500 |
| TPM（每分钟 Token） | 100,000 |

超限返回 `429 Too Many Requests`

### ✅ mimo2codex++ 的解决方案

通过**多账号并发**，将请求分散到多个 Key，突破单账号的并发上限和 RPM/TPM 限制。

**示例：** 3 个 Standard 套餐账号 = 60 并发 + 1500 RPM + 300K TPM

系统自动处理 429 限流、冷却避让和健康调度。

---

## 🚀 快速开始

### 方式一：一键安装（推荐）

```bash
# 1. 克隆仓库
git clone https://github.com/YOUR_USERNAME/mimo2codex-plusplus.git
cd mimo2codex-plusplus

# 2. 运行安装脚本
./install.sh

# 3. 启动服务
pnpm dev
```

### 方式二：手动安装

```bash
# 1. 克隆仓库
git clone https://github.com/YOUR_USERNAME/mimo2codex-plusplus.git
cd mimo2codex-plusplus

# 2. 安装依赖
pnpm install

# 3. 创建配置文件
cp .env.local.example .env.local

# 4. 启动服务
pnpm dev
```

### 方式三：Docker（即将支持）

```bash
docker pull YOUR_USERNAME/mimo2codex-plusplus
docker run -p 4020:4020 YOUR_USERNAME/mimo2codex-plusplus
```

---

## 📖 使用说明

### 1. 启动服务

```bash
pnpm dev
```

打开浏览器访问：`http://localhost:4020`

### 2. 添加 MiMo API Key

1. 点击 **"账号池"** 标签页
2. 输入你的 MiMo API Key（格式：`tp-xxx` 或 `sk-xxx`）
3. 点击 **"添加 Key"**

### 3. 启动实例

1. 点击 **"状态总览"** 标签页
2. 点击 **"全部启动"** 或单独启动每个实例
3. 等待实例状态变为 **"healthy"**

### 4. 生成 Codex 配置

1. 点击 **"Codex 接入"** 标签页
2. 输入你的 Gateway URL（默认：`http://127.0.0.1:4020`）
3. 点击 **"生成配置"**
4. 复制 `auth.json` 和 `config.toml` 到 Codex 配置目录

### 5. 重启 Codex

重启 Codex 后，它将通过 mimo2codex++ 网关访问 MiMo 服务。

---

## 🏗️ 核心功能

### 多账号并发调度
- 每个 Key 对应一个 mimo2codex 实例
- 自动分配端口和管理进程
- 健康检查和自动重启

### 智能负载均衡
- Health-weighted round robin
- 429 冷却避让
- Inflight 感知
- 自动故障转移

### 额度看板
- 实时显示每个 Key 的状态
- 请求统计（成功/失败/429）
- 冷却状态和恢复时间

### 一键配置
- 自动生成 Codex 配置文件
- 一键复制到剪贴板
- 支持自定义 Gateway URL

---

## 📁 项目结构

```
mimo2codex-plusplus/
├── src/
│   ├── app/
│   │   ├── api/           # API 路由
│   │   │   ├── keys/      # Key 管理
│   │   │   ├── pool/      # 实例池管理
│   │   │   └── codex/     # 配置生成
│   │   ├── v1/            # 统一网关入口
│   │   └── page.tsx       # 主页面
│   └── lib/
│       ├── encryption.ts  # AES-256-GCM 加密
│       ├── key-store.ts   # Key 持久化
│       ├── pool-manager.ts # 实例池管理
│       └── quota-client.ts # 额度查询
├── install.sh             # 一键安装脚本
└── README.md              # 本文件
```

---

## 🔧 配置说明

### 环境变量

创建 `.env.local` 文件：

```bash
# 可选：自定义端口
PORT=4020

# 可选：日志级别
LOG_LEVEL=info
```

### Codex 配置

生成的 `config.toml` 示例：

```toml
model = "mimo-v2.5-pro"
model_provider = "mimo"
model_context_window = 1000000
model_max_output_tokens = 131072
model_reasoning_effort = "xhigh"
disable_response_storage = true
network_access = "enabled"

[model_providers.mimo]
name = "mimo2codex++ gateway"
base_url = "http://127.0.0.1:4020/v1"
wire_api = "responses"
requires_openai_auth = true
request_max_retries = 1
```

---

## 🛡️ 安全说明

- API Key 使用 AES-256-GCM 加密存储
- 加密密钥自动生成并存储在 `data/.encryption-key`
- Key 仅在本地存储，不会上传到任何服务器
- 前端仅显示 Key 的前缀和后缀

---

## 📊 性能说明

### 多账号并发的优势

| 场景 | 单账号 | 3 个 Standard 账号 |
|------|--------|-------------------|
| 并发上限 | 20 | 60 |
| RPM | 500 | 1500 |
| TPM | 100K | 300K |
| 429 风险 | 高 | 低 |

### 资源消耗

- 每个 mimo2codex 实例占用约 50-100MB 内存
- 网关调度开销极低（<1ms）
- 建议：实例数量 ≤ CPU 核心数

---

## 🐛 常见问题

### Q: 启动后无法访问？
A: 检查端口 4020 是否被占用，或查看终端错误信息。

### Q: 实例状态一直是 "starting"？
A: 检查 mimo2codex 是否安装：`which mimo2codex`

### Q: 添加 Key 后无法启动实例？
A: 检查 Key 格式是否正确（`tp-xxx` 或 `sk-xxx`）

### Q: 如何更新到最新版本？
A: 
```bash
git pull
pnpm install
pnpm dev
```

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

### 开发环境

```bash
# 克隆仓库
git clone https://github.com/YOUR_USERNAME/mimo2codex-plusplus.git
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

### 提交规范

- `feat:` 新功能
- `fix:` 修复 bug
- `docs:` 文档更新
- `style:` 代码格式
- `refactor:` 重构
- `test:` 测试
- `chore:` 构建/工具

---

## 📄 许可证

MIT License

---

## 🙏 致谢

- [mimo2codex](https://github.com/user/mimo2codex) - 原始项目
- [Next.js](https://nextjs.org/) - Web 框架
- [Tailwind CSS](https://tailwindcss.com/) - 样式框架

---

## 📞 联系方式

- Issues: https://github.com/YOUR_USERNAME/mimo2codex-plusplus/issues
- Discussions: https://github.com/YOUR_USERNAME/mimo2codex-plusplus/discussions

---

**⭐ 如果这个项目对你有帮助，请给个 Star！**
