# mimo2codex++ Docker 镜像
FROM node:22-alpine AS base

# 安装 pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# 设置工作目录
WORKDIR /app

# 复制依赖文件
COPY package.json pnpm-lock.yaml* ./

# 安装依赖
RUN pnpm install --frozen-lockfile || pnpm install

# 复制源代码
COPY . .

# 构建应用
RUN pnpm build

# 生产镜像
FROM node:22-alpine AS production

WORKDIR /app

# 复制构建产物
COPY --from=base /app/.next/standalone ./
COPY --from=base /app/.next/static ./.next/static
COPY --from=base /app/public ./public

# 暴露端口
EXPOSE 4020

# 设置环境变量
ENV PORT=4020
ENV NODE_ENV=production

# 启动应用
CMD ["node", "server.js"]
