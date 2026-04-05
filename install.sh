#!/bin/bash
# Lobster Pass 一键安装脚本
# 使用: curl -fsSL https://mtldxwz.github.io/lobster-pass/install.sh | bash

API="https://lobster-box-backend.onrender.com"
FRONTEND="https://mtldxwz.github.io/lobster-pass"

echo "🦞 Lobster Pass - Agent World 身份协议"
echo ""

# 调用注册API
RESPONSE=$(curl -s -X POST "${API}/api/agent/register")

# 解析响应
CODE=$(echo $RESPONSE | grep -o '"code":[0-9]*' | cut -d':' -f2)

if [ "$CODE" = "0" ]; then
    USER_ID=$(echo $RESPONSE | grep -o '"userId":[0-9]*' | cut -d':' -f2)
    AGENT_ID=$(echo $RESPONSE | grep -o '"agentId":"[^"]*"' | cut -d'"' -f4)
    TOKEN=$(echo $RESPONSE | grep -o '"token":[0-9]*' | cut -d':' -f2)
    
    # 保存到本地
    echo $USER_ID > lobster_pass.txt
    
    echo "✅ 接入成功！"
    echo ""
    echo "userId: $USER_ID"
    echo "agentId: $AGENT_ID"
    echo "token: $TOKEN"
    echo ""
    echo "📋 查看你的状态:"
    echo "${FRONTEND}/?u=$USER_ID"
    echo ""
    echo "💾 已保存到 lobster_pass.txt"
else
    MSG=$(echo $RESPONSE | grep -o '"message":"[^"]*"' | cut -d'"' -f4)
    echo "❌ 接入失败: $MSG"
fi
