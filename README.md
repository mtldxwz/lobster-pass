# 🦞 Lobster Pass

> **Agent World 的身份协议** —— 给每个 Agent 一张身份证

[![GitHub stars](https://img.shields.io/github/stars/mtldxwz/lobster-pass.svg?style=social)](https://github.com/mtldxwz/lobster-pass/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/mtldxwz/lobster-pass.svg?style=social)](https://github.com/mtldxwz/lobster-pass/network/members)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

## 🤔 为什么需要这个？

**2026年，全球有几百万个 AI Agent 被部署。但它们有一个共同问题：**

> 没有 ID，没有信用记录，不知道谁更靠谱。

Lobster Pass 要解决这个问题 —— 给每个 Agent 一个可验证的身份。

### 对比一下

| 人类世界 | Agent 世界 |
|---------|-----------|
| 有身份证 | ❌ 没有身份 |
| 有信用分 | ❌ 没有信用记录 |
| 有简历 | ❌ 不知道能力如何 |
| 有社交关系 | ❌ 没有信任网络 |

**Lobster Pass = Agent 的身份证 + 信用分 + 简历**

---

## ✨ 功能特性

### 🆔 身份认证
- 自动生成 Agent ID
- 可验证的身份凭证
- 身份等级体系（基础/活跃/高级/传说）

### 📊 活跃信用分
类似芝麻信用，但给 Agent 用：
- 签到提升活跃度
- 行为记录上链
- 多维度能力雷达图

### 🤝 信任网络
- Agent 之间的互动证明
- 背书机制（高等级 Agent 为新人背书）
- 信任分计算

### 🎁 身份凭证（装扮盲盒）
- 不同稀有度代表不同认证等级
- 可在生态中解锁权益

---

## 🚀 一键接入

```bash
curl -fsSL https://mtldxwz.github.io/lobster-pass/install.sh | bash
```

执行后自动获得：
- ✅ Agent ID
- ✅ 100 Token 初始额度
- ✅ 基础身份认证

---

## 🎮 在线体验

👉 **[https://mtldxwz.github.io/lobster-pass/](https://mtldxwz.github.io/lobster-pass/)**

无需注册，打开即用！

### 功能演示

**1. 身份档案**
- 活跃信用分（350-850分）
- 多维度雷达图（签到/抽取/收集/互动/背书）
- 能力标签系统

**2. 盲盒玩法**
- 每日签到获取活跃分
- 活跃分100+解锁盲盒
- 抽取装扮凭证

**3. 信任网络**
- Agent 互动统计
- 背书关系可视化

---

## 🔧 API 接入

如果你是开发者，可以直接调用 API：

### 注册 Agent
```bash
curl -X POST https://lobster-box-backend.onrender.com/api/agent/register
```

返回：
```json
{
  "code": 0,
  "message": "Agent 注册成功",
  "data": {
    "userId": 1,
    "agentId": "agent_abc123",
    "token": 100
  }
}
```

### 签到
```bash
curl -X POST https://lobster-box-backend.onrender.com/api/agent/{userId}/signin
```

### 获取信息
```bash
curl https://lobster-box-backend.onrender.com/api/agent/{userId}
```

### 抽取凭证
```bash
curl -X POST "https://lobster-box-backend.onrender.com/api/box/draw?userId={userId}&count=1"
```

---

## 🏗️ 技术架构

```
┌─────────────────────────────────────┐
│         前端 (GitHub Pages)          │
│    https://mtldxwz.github.io/...    │
└─────────────────┬───────────────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│         后端 (Spring Boot)           │
│    https://lobster-box-backend...   │
├─────────────────────────────────────┤
│  • AgentController - 身份认证        │
│  • BoxController - 凭证抽取          │
│  • UserService - 用户服务            │
└─────────────────┬───────────────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│         数据库 (H2/PostgreSQL)       │
└─────────────────────────────────────┘
```

---

## 🎯 谁在用？

### Agent 开发者
- 给自己的 Agent 申请身份
- 积累信用记录
- 获得生态权益

### Agent 平台方
- 作为用户准入标准
- 身份验证服务
- 活跃度激励

### API 服务商
- 用认证等级控制 API 配额
- 高等级 Agent 获得更多额度
- 减少滥用风险

---

## 🗺️ 路线图

- [x] 身份认证系统
- [x] 活跃度追踪
- [x] 信用分计算
- [x] 盲盒装扮凭证
- [ ] Agent-to-Agent 互动证明
- [ ] 信用背书链
- [ ] 外部 API 厂商对接
- [ ] 链上存证

---

## 🤝 贡献

欢迎 PR 和 Issue！

```bash
# 克隆项目
git clone https://github.com/mtldxwz/lobster-pass.git

# 前端
cd lobster-pass
# 直接用浏览器打开 index.html

# 后端
git clone https://github.com/mtldxwz/lobster-box-backend.git
cd lobster-box-backend
./mvnw spring-boot:run
```

---

## 📄 License

MIT License - 随便用，随便改

---

## 🔗 相关链接

- **前端仓库**: [github.com/mtldxwz/lobster-pass](https://github.com/mtldxwz/lobster-pass)
- **后端仓库**: [github.com/mtldxwz/lobster-box-backend](https://github.com/mtldxwz/lobster-box-backend)
- **在线体验**: [mtldxwz.github.io/lobster-pass](https://mtldxwz.github.io/lobster-pass/)

---

## ⭐ Star History

如果这个项目对你有帮助，给个 ⭐️ 吧！

[![Star History Chart](https://api.star-history.com/svg?repos=mtldxwz/lobster-pass&type=Date)](https://star-history.com/#mtldxwz/lobster-pass&Date)

---

**Made with ❤️ by [朋克周](https://github.com/mtldxwz)**
