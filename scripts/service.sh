#!/bin/bash

PLIST_NAME="com.mimo2codex.plusplus"
PLIST_PATH="$HOME/Library/LaunchAgents/${PLIST_NAME}.plist"

case "$1" in
    start)
        echo "启动 mimo2codex++..."
        launchctl load "$PLIST_PATH"
        sleep 3
        curl -s http://localhost:4020/api/pool/status | python3 -c "import json,sys; d=json.load(sys.stdin); print(f'✅ 运行中: {d[\"totals\"][\"total\"]} 个账号, {d[\"totals\"][\"healthy\"]} 个健康')"
        ;;
    stop)
        echo "停止 mimo2codex++..."
        launchctl unload "$PLIST_PATH"
        echo "✅ 已停止"
        ;;
    restart)
        echo "重启 mimo2codex++..."
        launchctl unload "$PLIST_PATH"
        sleep 1
        launchctl load "$PLIST_PATH"
        sleep 3
        curl -s http://localhost:4020/api/pool/status | python3 -c "import json,sys; d=json.load(sys.stdin); print(f'✅ 运行中: {d[\"totals\"][\"total\"]} 个账号, {d[\"totals\"][\"healthy\"]} 个健康')"
        ;;
    status)
        if launchctl list | grep -q "$PLIST_NAME"; then
            echo "✅ mimo2codex++ 正在运行"
            curl -s http://localhost:4020/api/pool/status | python3 -c "import json,sys; d=json.load(sys.stdin); print(f'   账号: {d[\"totals\"][\"total\"]} 个, 健康: {d[\"totals\"][\"healthy\"]} 个')"
        else
            echo "❌ mimo2codex++ 未运行"
        fi
        ;;
    logs)
        tail -f /tmp/mimo2codex-plusplus.log
        ;;
    *)
        echo "用法: $0 {start|stop|restart|status|logs}"
        exit 1
        ;;
esac
