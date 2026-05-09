# 🎨 素材下载与安装指南

## 步骤 1: 下载 Kenney 素材

### 访问地址
https://kenney.nl/assets

### 推荐素材包

#### 必下载 (核心素材)
| 素材包名称 | 搜索关键词 | 说明 |
|-----------|-----------|------|
| **Platformer Art** | `platformer` | 主角、敌人、瓦片、道具 |
| **Platformer Pack Extended** | `platformer extended` | 更多瓦片变体 |

#### 可选下载 (扩展素材)
| 素材包名称 | 说明 |
|-----------|------|
| **1-Bit Pack** | 简约黑白风格 |
| **Pixel Platformer** | 像素风格平台者 |
| **Toon Characters** | 卡通角色 |

---

## 步骤 2: 解压文件

下载后你会得到 ZIP 文件，解压后应该包含：

```
kenney-platformer/
├── Spritesheets/          # 精灵图表 (推荐使用)
├── Tiles/                 # 单独瓦片
├── Characters/            # 角色动画
├── Enemies/               # 敌人素材
├── Items/                 # 道具和收集物
└── License.txt            # 许可说明 (CC0)
```

---

## 步骤 3: 放入项目

将解压后的文件复制到项目文件夹：

```bash
# 在项目根目录执行
cp -r ~/Downloads/kenney-platformer/* /home/admin/.openclaw/workspace/godot-game/assets/sprites/
```

或者手动复制：
1. 打开下载文件夹
2. 全选所有素材
3. 粘贴到 `godot-game/assets/sprites/`

---

## 步骤 4: 在 Godot 中导入

### 4.1 刷新 Godot 资源面板
1. 打开 Godot
2. 切换到 `FileSystem` 面板
3. 右键点击 `assets/sprites` 文件夹
4. 选择 `Reload`

### 4.2 创建 TileSet

1. 打开 `resources/terrain_tileset.tres`
2. 在 Inspector 面板找到 `TileSet` 属性
3. 点击 `Add New Atlas Source`
4. 选择你的瓦片图片 (通常是 `tilesheet.png` 或类似文件)
5. 设置瓦片大小为 `32x32`

### 4.3 设置玩家精灵

1. 打开 `scenes/player.tscn`
2. 选中 `Sprite2D` 节点
3. 在 Inspector 的 `Texture` 属性中：
   - 点击文件夹图标
   - 选择玩家角色图片
4. 调整 `Region` 设置裁剪到正确帧

---

## 步骤 5: 验证安装

### 检查清单
- [ ] `assets/sprites/` 文件夹里有素材文件
- [ ] Godot 的 FileSystem 面板能看到新文件
- [ ] TileSet 能正确显示瓦片预览
- [ ] 玩家场景能看到角色精灵

### 测试运行
1. 打开 `scenes/main.tscn`
2. 点击运行按钮 (▶️)
3. 用 A/D 或 ←/→ 移动
4. 用 W/↑/空格 跳跃

---

## 📋 需要的素材清单

### 玩家角色
- [ ] 站立动画 (idle)
- [ ] 行走动画 (run/walk)
- [ ] 跳跃动画 (jump)
- [ ] 受伤/死亡动画 (可选)

### 地形瓦片
- [ ] 地面瓦片 (grass/dirt/stone)
- [ ] 平台瓦片
- [ ] 背景瓦片 (可选)
- [ ] 装饰瓦片 (可选)

### 敌人
- [ ] 基础敌人 (巡逻用)
- [ ] 飞行敌人 (可选)
- [ ] BOSS (可选)

### 收集物
- [ ] 金币/硬币
- [ ] 宝石/道具
- [ ] 心形 (生命值)

### UI (可选)
- [ ] 心形图标
- [ ] 金币图标
- [ ] 数字字体

---

## 🔧 常见问题

### Q: 瓦片大小不对？
A: 检查 TileSet 设置中的 `tile_size`，应该是 `32x32`

### Q: 动画不会播放？
A: 需要使用 `AnimatedSprite2D` 而不是 `Sprite2D`，并设置 `SpriteFrames`

### Q: 图片导入后模糊？
A: 在 Import 面板关闭 `Filter` 选项，保持像素清晰

### Q: 找不到合适的素材？
A: 试试这些替代网站：
- https://itch.io/game-assets/free/tag-pixel-art
- https://opengameart.org

---

## 📞 需要帮助？

下载或导入遇到问题，告诉我具体情况，我帮你解决！

---
_最后更新：2026-05-09 | 小虾 🦐_
