# 🎮 玩家动画配置指南

## ✅ 已完成的配置

- [x] 创建 AnimatedSprite2D 场景
- [x] 创建 SpriteFrames 资源文件
- [x] 更新玩家脚本 (支持动画切换)
- [x] 调整碰撞盒尺寸 (32x64 角色)

---

## 📝 在 Godot 中需要手动完成的步骤

### 步骤 1: 打开玩家场景

1. 启动 Godot 4.x
2. 导入项目 (选择 `project.godot`)
3. 双击打开 `scenes/player.tscn`

---

### 步骤 2: 配置 SpriteFrames 资源

1. 在场景树中选中 `AnimatedSprite2D` 节点
2. 在 Inspector 面板找到 `Sprite Frames` 属性
3. 点击文件夹图标，选择 `res://resources/player_sprites.tres`

---

### 步骤 3: 编辑动画帧 (重要！)

1. 点击 `Sprite Frames` 属性旁边的资源图标 (📄)
2. 底部会打开 **SpriteFrames** 面板

#### 对每个动画执行以下操作：

**idle 动画:**
1. 选中 `idle` 动画
2. 点击 `Idle.png` 纹理
3. 在底部设置：
   - **Horizontal Frames**: `18` (根据实际帧数)
   - **Vertical Frames**: `1`
   - **Speed**: `8` (FPS)

**run 动画:**
1. 选中 `run` 动画
2. 点击 `Run.png` 纹理
3. 设置：
   - **Horizontal Frames**: `18`
   - **Vertical Frames**: `1`
   - **Speed**: `12`

**jump 动画:**
1. 选中 `jump` 动画
2. 点击 `Jump.png` 纹理
3. 设置：
   - **Horizontal Frames**: `20`
   - **Vertical Frames**: `1`
   - **Speed**: `12`
   - **Loop**: 取消勾选 (跳跃动画不循环)

**die 动画:**
1. 选中 `die` 动画
2. 点击 `Die.png` 纹理
3. 设置：
   - **Horizontal Frames**: `18`
   - **Vertical Frames**: `1`
   - **Speed**: `8`
   - **Loop**: 取消勾选

**hit 动画:**
1. 选中 `hit` 动画
2. 点击 `Hit_Stand.png` 纹理
3. 设置：
   - **Horizontal Frames**: `12`
   - **Vertical Frames**: `1`
   - **Speed**: `12`
   - **Loop**: 取消勾选

---

### 步骤 4: 调整碰撞盒

1. 在场景树中选中 `CollisionShape2D` 节点
2. 在 Inspector 点击 `Shape` 属性
3. 选择 `RectangleShape2D`
4. 设置 **Size** 为 `Vector2(16, 32)`

---

### 步骤 5: 测试运行

1. 打开 `scenes/main.tscn`
2. 点击运行按钮 (▶️)
3. 测试：
   - **A/D 或 ←/→**: 左右移动 (播放 run 动画)
   - **W/↑/空格**: 跳跃 (播放 jump 动画)
   - **站立不动**: 待机 (播放 idle 动画)

---

## 🎨 动画帧数参考

根据素材分析：

| 动画名称 | 图片尺寸 | 单帧尺寸 | 帧数 | 建议 FPS |
|---------|---------|---------|------|---------|
| idle | 576x64 | 32x64 | 18 | 8 |
| run | 576x64 | 32x64 | 18 | 12 |
| jump | 640x64 | 32x64 | 20 | 12 |
| die | 576x64 | 32x64 | 18 | 8 |
| hit_stand | 384x64 | 32x64 | 12 | 12 |

---

## ⚠️ 常见问题

### Q: 动画播放太快/太慢？
A: 调整 SpriteFrames 面板中的 **Speed** 值 (FPS)

### Q: 角色显示不完整？
A: 检查 AnimatedSprite2D 的 Position，应该是 `(0, -16)` 让角色站在碰撞盒上

### Q: 动画不切换？
A: 确保脚本中的 `_update_animation()` 被调用，检查控制台有无错误

### Q: 角色方向不对？
A: 代码中已自动处理 `flip_h`，如果反了可以调整逻辑

---

## 🚀 下一步

玩家动画配置完成后，可以：

1. **配置地形 TileSet** - 搭建关卡
2. **配置敌人** - 添加敌人 AI 和动画
3. **添加收集物** - 金币、道具等
4. **设计关卡** - 用 TileMap 绘制

告诉我你想做哪个！🦐

---
_最后更新：2026-05-09 | 小虾 🦐_
