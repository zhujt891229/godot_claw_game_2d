#!/bin/bash
# Godot 项目自动提交推送脚本

cd /home/admin/.openclaw/workspace/godot-game

# 配置 git 用户信息（如果未设置）
git config user.name "Wuying" 2>/dev/null || true
git config user.email "admin@local" 2>/dev/null || true

# 检查是否有改动
if git diff --quiet && git diff --cached --quiet; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 没有改动，跳过提交"
    exit 0
fi

# 添加所有改动
git add -A

# 提交
git commit -m "chore: auto-commit $(date '+%Y-%m-%d %H:%M:%S')"

# 推送
git pull --rebase && git push

if [ $? -eq 0 ]; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 自动提交推送成功"
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 推送失败，可能需要手动处理冲突"
fi
