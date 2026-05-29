# mimo2codex++ 推广文案

## 📱 小红书/微信朋友圈

```
🔥 解决小米 MiMo 429 限流问题！

用 Codex 的时候经常遇到 429 错误？任务做到一半被限流？

我做了一个开源工具 mimo2codex++，可以：
✅ 同时使用多个小米账号
✅ 自动切换，不再怕 429
✅ 并发上限直接翻倍
✅ 实时看额度使用情况

2 个账号 = 40 并发 + 1000 RPM + 200K TPM

开源地址：https://github.com/2319582090-spec/mimo2codex-plusplus

#小米MiMo #Codex #AI编程 #开源
```

## 💬 V2EX 帖子

```
标题：[开源] mimo2codex++ - 解决小米 MiMo 429 限流的多账号并发网关

各位好，

最近在用 Codex + 小米 MiMo 的时候，经常遇到 429 Too Many Requests 错误，
尤其是并发任务多的时候，一个账号根本扛不住。

于是我做了一个开源工具 mimo2codex++，核心功能：

1. 多账号并发调度 - 同时使用多个 MiMo API Key
2. 智能 429 避让 - 遇到限流自动切换到其他账号
3. 额度可视化 - 实时看到每个账号的使用情况
4. 一键配置 - 自动生成 Codex 配置

实际效果：
- 2 个账号 = 40 并发（原来是 20）
- 2 个账号 = 1000 RPM（原来是 500）
- 429 错误大幅减少

技术栈：Next.js + TypeScript + Tailwind CSS
开源地址：https://github.com/2319582090-spec/mimo2codex-plusplus

欢迎 Star、Fork、提 Issue！

附：Dashboard 截图
```

## 📝 知乎文章

```
标题：如何解决小米 MiMo API 的 429 限流问题？mimo2codex++ 多账号并发方案

## 背景

最近小米的 MiMo 模型非常火，很多开发者都在用它配合 Codex 进行 AI 编程。
但是，单账号的并发限制（Standard 套餐 20 并发）和速率限制（500 RPM）让很多人头疼。

尤其是当你需要同时运行多个任务的时候，429 Too Many Requests 错误就成了家常便饭。

## 解决方案

我开发了一个开源工具 mimo2codex++，核心思路很简单：

**用多个账号，分担请求压力。**

### 架构

```
Codex → mimo2codex++ → MiMo Key 1 (并发 20)
                     → MiMo Key 2 (并发 20)
                     → MiMo Key N (并发 20)
```

### 核心功能

1. **多账号并发调度**
   - 每个 Key 对应一个 mimo2codex 实例
   - 智能负载均衡，优先选择健康的实例

2. **429 智能避让**
   - 遇到 429 自动切换到其他账号
   - 冷却期结束后自动恢复

3. **额度可视化**
   - 实时显示每个 Key 的状态
   - 请求统计、冷却状态一目了然

4. **一键配置**
   - 自动生成 Codex 配置
   - 复制粘贴即可使用

## 实际效果

| 指标 | 单账号 | 2 账号 | 3 账号 |
|------|--------|--------|--------|
| 并发上限 | 20 | 40 | 60 |
| RPM | 500 | 1000 | 1500 |
| TPM | 100K | 200K | 300K |
| 429 风险 | 高 | 低 | 很低 |

## 如何使用

1. 克隆仓库
2. 运行安装脚本
3. 添加你的 MiMo API Key
4. 生成 Codex 配置
5. 重启 Codex

详细步骤请查看：https://github.com/2319582090-spec/mimo2codex-plusplus

## 总结

mimo2codex++ 不是什么黑科技，就是用多个账号分担压力。
简单、有效、开源。

如果你也在用 MiMo + Codex，不妨试试。
```

## 🐦 Twitter/X

```
🚀 Just released mimo2codex++ - an open-source tool to bypass Xiaomi MiMo's rate limits!

✅ Use multiple API keys simultaneously
✅ Auto-failover on 429 errors
✅ 2x concurrency with 2 accounts
✅ Real-time quota dashboard

GitHub: https://github.com/2319582090-spec/mimo2codex-plusplus

#OpenSource #AI #Codex #MiMo
```

## 📺 B站/YouTube 视频脚本

```
标题：小米 MiMo 老是 429？这个开源工具帮你解决！

开场：
大家好，最近很多小伙伴在用小米 MiMo 配合 Codex 编程的时候，
经常遇到 429 Too Many Requests 错误。
今天给大家分享一个我做的开源工具，可以彻底解决这个问题。

正文：
1. 问题分析
   - 单账号并发限制（20 并发）
   - 速率限制（500 RPM）
   - 多任务时容易触发 429

2. 解决方案
   - mimo2codex++ 的原理
   - 多账号并发调度
   - 智能 429 避让

3. 实际演示
   - 安装过程
   - 添加多个 Key
   - 查看 Dashboard
   - 对比效果

4. 性能对比
   - 单账号 vs 多账号
   - 429 错误频率对比

结尾：
这就是 mimo2codex++，一个简单有效的解决方案。
开源地址在简介里，欢迎 Star 支持！
```
