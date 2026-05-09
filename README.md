# 2D Platformer - Godot 4.x 项目

🦐 像素风横版平台跳跃游戏模板

## 项目结构

```
godot-game/
├── scenes/          # 游戏场景 (.tscn)
│   ├── main.tscn    # 主场景
│   └── player.tscn  # 玩家场景
├── scripts/         # GDScript 代码 (.gd)
│   ├── player.gd    # 玩家控制
│   ├── enemy.gd     # 敌人 AI
│   ├── camera.gd    # 摄像机跟随
│   └── collectible.gd  # 收集物
├── assets/
│   ├── sprites/     # 图片素材 (待添加)
│   ├── audio/       # 音效音乐 (待添加)
│   └── fonts/       # 字体 (待添加)
├── resources/       # 资源文件
│   └── terrain_tileset.tres  # 地形 TileSet
├── project.godot    # 项目配置
└── README.md        # 本文件
```

## 操作说明

| 按键 | 功能 |
|------|------|
| A / ← | 向左移动 |
| D / → | 向右移动 |
| W / ↑ / 空格 | 跳跃 |

## 快速开始

1. 用 Godot 4.x 打开 `project.godot`
2. 运行主场景 (`scenes/main.tscn`)
3. 添加瓦片素材到 `resources/terrain_source.tres`
4. 在 TileMapLayer 上绘制关卡

## 待完成

- [ ] 添加玩家精灵素材 (32x32 像素)
- [ ] 添加敌人精灵素材
- [ ] 创建 TileSet 瓦片集
- [ ] 设计第一个关卡
- [ ] 添加收集物 (金币)
- [ ] 添加 UI (血量、分数)
- [ ] 添加音效和背景音乐

## 下一步

告诉我你想先做什么，我可以帮你：
- 写更复杂的玩家控制 (双跳、冲刺、爬墙)
- 创建敌人类型 (巡逻、追踪、飞行)
- 设计关卡系统
- 添加 UI 界面
- 其他功能...

---
_项目由 小虾 🦐 协助创建_
