# 🚀 快速开始 - 5 分钟配置指南

## 前提条件
- ✅ Godot 4.6 已安装
- ✅ 素材已放入 `assets/sprites/`
- ✅ 项目已导入

---

## 第 1 步：配置玩家动画 (2 分钟)

1. 打开 `scenes/player.tscn`
2. 选中 `AnimatedSprite2D` 节点
3. 点击 `Sprite Frames` → 选择 `player_sprites.tres`
4. 点击资源图标打开 SpriteFrames 面板
5. 对每个动画设置帧数：

```
idle  → Horizontal: 18, Speed: 8
run   → Horizontal: 18, Speed: 12
jump  → Horizontal: 20, Speed: 12
die   → Horizontal: 18, Speed: 8
hit   → Horizontal: 12, Speed: 12
```

---

## 第 2 步：配置地形 TileSet (3 分钟)

1. 打开 `scenes/level_01.tscn`
2. 选中 `TileMapLayer` 节点
3. Inspector → `Tile Set` → `[New TileSet]`
4. 点击资源图标打开 TileSet 编辑器
5. 底部面板点 `+` → 选择瓦片图：
   ```
   assets/sprites/Asset/Tilemap/Tilemap_ProjectLittleAdventurerAndie2D.png
   ```
6. 设置 `Tile Size` = `32x32`
7. 保存 TileSet 为 `resources/terrain_tileset.tres`

---

## 第 3 步：绘制关卡 (5 分钟)

1. 保持 `TileMapLayer` 选中
2. 底部打开 **TileMap** 面板
3. 选择 **Paint** 模式
4. 选择地面瓦片
5. 在 2D 视图中绘制：
   - 地面：从 (-400, 150) 到 (400, 150)
   - 平台 1: (-150, 50) 3 格宽
   - 平台 2: (0, -30) 3 格宽
   - 平台 3: (150, 50) 3 格宽

---

## 第 4 步：添加碰撞 (2 分钟)

### 方法 A: TileSet 碰撞 (推荐)

1. 在 TileSet 编辑器
2. 选中地面瓦片
3. 右侧 **Tile Data** → **Physics**
4. 点 `+` 添加碰撞形状
5. 绘制矩形 (32x32)

### 方法 B: StaticBody2D

1. 在 `TileMapLayer` 下创建 `StaticBody2D`
2. 添加 `CollisionShape2D`
3. 设置形状覆盖地面区域

---

## 第 5 步：测试运行！(1 分钟)

1. 确保 `level_01.tscn` 打开
2. 点运行按钮 ▶️
3. 操作：
   - **A/D** 或 **←/→** 移动
   - **W/↑/空格** 跳跃
- **J/X** 攻击

---

## UI 说明

- **❤️ 心形**：当前生命值（3 点满血）
- **分数**：收集金币获得分数
- **关卡标签**：显示当前关卡

## 音效

游戏已集成音效系统，支持：
- 跳跃/二段跳音效
- 攻击音效
- 受伤/死亡音效
- 金币收集音效
- 敌人受伤/死亡音效

将音效文件放入 `assets/audio/sfx/` 即可自动播放。
详见 `assets/audio/AUDIO_GUIDE.md`

---

## ✅ 检查清单

测试时确认：

- [ ] 玩家从 (-300, -100) 生成
- [ ] 可以左右移动
- [ ] 可以跳跃
- [ ] 站在平台上不掉落
- [ ] 摄像机跟随玩家
- [ ] 动画正常播放 (idle/run/jump)

---

## 🐛 遇到问题？

### 玩家掉下去
→ 检查地面有没有碰撞形状

### 动画不播放
→ 检查 SpriteFrames 是否关联，帧数设置是否正确

### 看不到角色
→ 检查 AnimatedSprite2D 的 Texture 是否设置

### 黑屏/空白
→ 检查 TileSet 是否正确配置

---

## 📖 详细文档

- 玩家配置：`PLAYER_SETUP.md`
- 关卡配置：`LEVEL_SETUP.md`
- 素材指南：`ASSETS_GUIDE.md`

---

**配置完成后，告诉我下一步做什么！**

选项：
1. 添加敌人 AI
2. 添加收集物 (金币)
3. 添加 UI 界面
4. 其他需求

🦐 小虾待命！
