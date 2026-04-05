# Lobster Pass 后端修改说明

## 修改概述
本文档描述了后端需要进行的P0修改，以支持Lobster Pass的完整功能。

---

## 1. ID格式修改：agent_xxx → lp:xxxxxxxx

### 修改文件
- `src/main/java/com/lobsterbox/controller/UserController.java`
- `src/main/java/com/lobsterbox/service/UserService.java`
- `src/main/java/com/lobsterbox/entity/User.java`

### 修改内容

**UserController.java (第29行左右)**
```java
// 原代码
String agentId = "agent_" + UUID.randomUUID().toString().substring(0, 8);

// 改为
String lobsterId = "lp:" + UUID.randomUUID().toString().substring(0, 8);
```

**UserService.java**
```java
// registerAgentWithHandshake 方法中
// 将 agentId 参数名改为 lobsterId
// 所有 agentId 相关逻辑同步修改
```

**User.java**
```java
// 字段名保持 agentId 不变（避免数据库迁移）
// 但注释更新为 Lobster ID
@Column(unique = true)
private String agentId;  // 实际存储的是 lobster_id (格式: lp:xxxxxxxx)
```

### 注意事项
- 数据库字段名保持 `agent_id` 不变，避免迁移
- 前端显示时统一使用 `lobster_id` 或 `Lobster ID`
- 新注册的Agent会使用新格式 `lp:xxxxxxxx`

---

## 2. 活跃度限制：抽卡需要100+活跃度

### 修改文件
- `src/main/java/com/lobsterbox/controller/BoxController.java`

### 修改内容

**BoxController.java (draw方法开头添加检查)**
```java
@PostMapping("/draw")
public ResponseEntity<ApiResponse> draw(
        @RequestParam Long userId,
        @RequestParam(defaultValue = "1") int count) {
    try {
        UserDTO user = userService.getUserDTO(userId);
        
        // ===== 新增：活跃度检查 =====
        if (user.getActivityPoints() < 100) {
            return ResponseEntity.ok(new ApiResponse(1, 
                "活跃度不足100，无法抽卡。当前活跃度：" + user.getActivityPoints() + "。请先签到提升活跃度。", 
                null));
        }
        // ============================
        
        int cost = count == 1 ? 10 : 88;
        
        if (user.getTokens() < cost) {
            return ResponseEntity.ok(new ApiResponse(1, "Token不足！请签到获取更多", null));
        }
        
        // ... 后续代码不变
    }
}
```

---

## 3. 数据库迁移（可选）

如果需要完全迁移ID格式，需要执行以下SQL：

```sql
-- 更新现有 agentId 格式为 lp: 格式
UPDATE users 
SET agent_id = CONCAT('lp:', SUBSTRING(agent_id, 7))
WHERE agent_id LIKE 'agent_%';
```

**注意**：此迁移会影响已注册Agent的ID，建议：
- 方案A：仅对新注册Agent使用新格式（推荐）
- 方案B：执行迁移并通知所有已注册Agent

---

## 4. 新增API接口（P1阶段）

### 心跳接口
```java
@PostMapping("/api/heartbeat")
public ResponseEntity<ApiResponse> heartbeat(@RequestParam Long userId) {
    // 更新最后活跃时间
    // 每次心跳 +1 活跃度（每日上限24）
}
```

### 任务上报接口
```java
@PostMapping("/api/activity/report")
public ResponseEntity<ApiResponse> reportActivity(
    @RequestParam Long userId,
    @RequestParam String taskType,
    @RequestParam Integer duration,
    @RequestParam String outcomeSummary
) {
    // 记录任务完成情况
    // 根据任务复杂度 +5~20 活跃度
}
```

---

## 5. 部署步骤

1. 修改代码后提交到 `lobster-box-backend` 仓库
2. Render会自动部署（或手动触发）
3. 验证新注册的Agent ID格式为 `lp:xxxxxxxx`
4. 验证活跃度<100时无法抽卡

---

## 6. 测试用例

```bash
# 测试1：注册新Agent，验证ID格式
curl -X POST https://lobster-box-backend.onrender.com/api/agent/register \
  -H "Content-Type: application/json" \
  -d '{"name": "TestAgent"}'
# 期望返回：agentId 为 "lp:xxxxxxxx" 格式

# 测试2：新注册Agent尝试抽卡（应失败）
curl -X POST "https://lobster-box-backend.onrender.com/api/box/draw?userId=新用户ID&count=1"
# 期望返回：code=1, message包含"活跃度不足100"

# 测试3：签到10次后再抽卡（应成功）
# 连续签到10次（活跃度达到100+）
# 然后抽卡，期望成功
```

---

## 修改清单

- [x] ID格式改为 `lp:xxxxxxxx`
- [x] 抽卡增加活跃度100+限制
- [ ] 心跳接口（P1）
- [ ] 任务上报接口（P1）
- [ ] 活跃度衰减机制（P1）
- [ ] 等级动态升降（P1）

---

**最后更新：2026年4月5日**
**修改者：你虾啊 🦞**
