# 贡献指南

感谢您考虑为解压泡泡龙项目做出贡献！

## 📋 目录

- [行为准则](#行为准则)
- [如何贡献](#如何贡献)
- [开发流程](#开发流程)
- [代码规范](#代码规范)
- [提交规范](#提交规范)

## 行为准则

本项目采用贡献者公约作为行为准则。参与本项目即表示您同意遵守其条款。

## 如何贡献

### 报告Bug

如果您发现了bug，请创建一个Issue并包含：

1. **Bug描述**：清晰简洁地描述bug
2. **复现步骤**：详细的复现步骤
3. **预期行为**：您期望发生什么
4. **实际行为**：实际发生了什么
5. **截图**：如果适用，添加截图
6. **环境信息**：
   - DevEco Studio版本
   - HarmonyOS SDK版本
   - 设备型号

### 建议新功能

如果您想建议新功能，请创建一个Issue并包含：

1. **功能描述**：详细描述您希望的功能
2. **使用场景**：为什么需要这个功能
3. **实现建议**：如果您有实现想法，请描述

### 提交代码

1. Fork本仓库
2. 创建您的特性分支
3. 进行您的更改
4. 确保代码通过所有测试
5. 提交您的更改
6. 推送到分支
7. 创建Pull Request

## 开发流程

### 1. 设置开发环境

```bash
# 克隆您的fork
git clone https://github.com/your-username/relaxing-bubble-game.git

# 进入项目目录
cd relaxing-bubble-game

# 安装依赖
ohpm install
```

### 2. 创建分支

```bash
# 创建并切换到新分支
git checkout -b feature/your-feature-name
```

分支命名规范：
- `feature/` - 新功能
- `bugfix/` - Bug修复
- `refactor/` - 代码重构
- `docs/` - 文档更新

### 3. 进行开发

- 遵循代码规范
- 编写清晰的注释
- 更新相关文档

### 4. 测试

在提交前，请确保：
- 代码可以正常编译
- 在模拟器或真机上运行正常
- 新功能工作正常
- 没有引入新的bug

### 5. 提交更改

```bash
# 添加更改
git add .

# 提交
git commit -m "feat: 添加新功能描述"

# 推送
git push origin feature/your-feature-name
```

### 6. 创建Pull Request

在GitHub上创建PR时，请：
- 填写清晰的标题和描述
- 关联相关的Issue
- 等待代码审查

## 代码规范

### ArkTS代码规范

1. **命名规范**
   - 类名：PascalCase（如 `GameDataManager`）
   - 函数名：camelCase（如 `initGame`）
   - 变量名：camelCase（如 `playerCoins`）
   - 常量：UPPER_SNAKE_CASE（如 `MAX_LEVEL`）

2. **文件结构**
   ```typescript
   // 1. 导入语句
   import { ... } from '...';

   // 2. 常量定义
   const MAX_VALUE = 100;

   // 3. 类型/接口定义
   interface GameConfig { ... }

   // 4. 类定义
   export class GameManager { ... }
   ```

3. **注释规范**
   ```typescript
   /**
    * 函数说明
    * @param paramName 参数说明
    * @returns 返回值说明
    */
   function functionName(paramName: type): returnType {
     // 实现
   }
   ```

4. **组件规范**
   - 使用 `@Component` 装饰器
   - 状态变量使用 `@State` 或 `@Prop`
   - 组件结构清晰，职责单一

### UI设计规范

1. **颜色使用**
   - 主色：#4ECDC4（青色）
   - 辅助色：#FF6B6B（红色）
   - 强调色：#FFD700（金色）
   - 背景色：#E8F4F8（浅蓝）

2. **间距规范**
   - 小间距：5-10vp
   - 中间距：15-20vp
   - 大间距：30-40vp

3. **字体规范**
   - 标题：24-36fp
   - 正文：14-18fp
   - 说明：12-14fp

## 提交规范

使用约定式提交格式：

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type类型

- `feat`: 新功能
- `fix`: Bug修复
- `docs`: 文档更新
- `style`: 代码格式（不影响功能）
- `refactor`: 代码重构
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建过程或辅助工具

### 示例

```
feat(shop): 添加新道具系统

- 添加5种新道具
- 实现道具购买逻辑
- 添加道具使用效果

Closes #123
```

## 代码审查

所有PR都需要经过代码审查。审查重点：

1. 代码质量
2. 是否遵循规范
3. 是否有潜在bug
4. 性能影响
5. 文档完整性

## 获取帮助

如果您有任何问题，可以：
- 创建Issue提问
- 查看现有文档
- 联系维护者

再次感谢您的贡献！
