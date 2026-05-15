# 🎨 视差背景系统说明

## ✅ 已完成的改进

### 更新内容
将 level_01 和 level_02 场景中的简单 ColorRect 背景替换为**6层专业视差背景系统**，使用项目中的实际图片素材。

---

## 📋 视差层结构

### 层级详情（从远到近）

| 层级 | 节点名称 | 移动速度 | 素材文件 | 说明 |
|------|---------|---------|---------|------|
| 1 | SkyLayer | 0.0 (静止) | 00_ProjectLittleAdventurerAndie2D.png | 天空背景，完全固定 |
| 2 | MountainFarLayer | 0.1 (极慢) | 01_ProjectLittleAdventurerAndie2D.png | 远山，几乎不动 |
| 3 | MountainMidLayer | 0.2 (慢速) | 02_ProjectLittleAdventurerAndie2D.png | 中山，缓慢移动 |
| 4 | TreesFarLayer | 0.3 (中慢) | 03_ProjectLittleAdventurerAndie2D.png | 远树，中等偏慢 |
| 5 | TreesMidLayer | 0.5 (中速) | 04_ProjectLittleAdventurerAndie2D.png | 近树，中等速度 |
| 6 | CloseLayer | 0.7 (较快) | CBG01_ProjectLittleAdventurerAndie2D.png | 近景装饰，较快移动 |

---

## 🎯 技术细节

### 视差原理
```
motion_scale 值越小 → 移动越慢 → 感觉越远
motion_scale 值越大 → 移动越快 → 感觉越近
```

### 配置参数
- **motion_mirroring**: `Vector2(1920, 0)` - 水平镜像宽度 1920px，实现无缝循环
- **scale**: `Vector2(2, 2)` - 所有背景图放大 2 倍以适配高清显示
- **position**: 各层垂直位置不同，营造深度感

### 节点结构
```
ParallaxBackground (Parallax2D)
├── SkyLayer (ParallaxLayer)
│   └── SkySprite (Sprite2D)
├── MountainFarLayer (ParallaxLayer)
│   └── MountainFarSprite (Sprite2D)
├── MountainMidLayer (ParallaxLayer)
│   └── MountainMidSprite (Sprite2D)
├── TreesFarLayer (ParallaxLayer)
│   └── TreesFarSprite (Sprite2D)
├── TreesMidLayer (ParallaxLayer)
│   └── TreesMidSprite (Sprite2D)
└── CloseLayer (ParallaxLayer)
    └── CloseSprite (Sprite2D)
```

---

## 📁 使用的素材

### 背景图片位置
```
assets/sprites/Asset/Background/
├── 00_ProjectLittleAdventurerAndie2D.png      (175.1KB) - 天空
├── 01_ProjectLittleAdventurerAndie2D.png      (131.3KB) - 远山
├── 02_ProjectLittleAdventurerAndie2D.png       (20.5KB) - 中山
├── 03_ProjectLittleAdventurerAndie2D.png       (18.4KB) - 远树
├── 04_ProjectLittleAdventurerAndie2D.png       (17.2KB) - 近树
└── CloseBackground/
    └── CBG01_ProjectLittleAdventurerAndie2D.png (19.3KB) - 近景
```

### 可用但未使用的素材
- `05_ProjectLittleAdventurerAndie2D.png` (9.1KB) - 可作为额外前景层
- `Sunshine_ProjectLittleAdventurerAndie2D.png` (3.8KB) - 阳光效果
- `Particles_ProjectLittleAdventurerAndie2D.png` (15.1KB) - 粒子效果
- `CloseBackground/CBG02-05` - 更多近景变体

---

## 🎮 视觉效果

### 改进前
- ❌ 简单的纯色 ColorRect
- ❌ 只有 3 层（天空、山、中景）
- ❌ 缺乏层次感和深度

### 改进后
- ✅ 真实的像素风格背景图
- ✅ 6 层精细视差效果
- ✅ 丰富的视觉层次和深度感
- ✅ 专业的游戏级背景系统

---

## 🔧 自定义调整

### 修改视差速度
在 Godot 编辑器中：
1. 选择对应的 ParallaxLayer 节点
2. 修改 Inspector 中的 `Motion Scale` 属性
3. 值范围建议：0.0 (静止) ~ 1.0 (与摄像机同步)

### 添加新层
```gdscript
# 在场景中添加新的 ParallaxLayer
[node name="ExtraLayer" type="ParallaxLayer" parent="ParallaxBackground"]
motion_scale = Vector2(0.4, 0.4)  # 自定义速度
motion_mirroring = Vector2(1920, 0)

[node name="ExtraSprite" type="Sprite2D" parent="ParallaxBackground/ExtraLayer"]
texture = preload("res://assets/sprites/Asset/Background/05_ProjectLittleAdventurerAndie2D.png")
scale = Vector2(2, 2)
```

### 调整图层顺序
在 Godot 编辑器中拖动 ParallaxLayer 节点上下移动即可改变渲染顺序（上层的在后面）。

---

## 💡 优化建议

### 性能优化
- ✅ 已使用 motion_mirroring 实现无缝循环，无需手动拼接
- ✅ Sprite2D 比 ColorRect 稍耗资源，但视觉效果更好
- ⚠️ 如果性能紧张，可减少层数或降低 scale 值

### 视觉增强（可选）
1. **添加阳光效果**
   - 使用 `Sunshine_ProjectLittleAdventurerAndie2D.png`
   - 放在 SkyLayer 之上，设置半透明

2. **添加粒子效果**
   - 使用 `Particles_ProjectLittleAdventurerAndie2D.png`
   - 创建 GPUParticles2D 节点模拟飘雪/落叶

3. **使用更多近景变体**
   - CBG02-05 可用于不同关卡或随机切换

---

## 📊 测试要点

运行游戏时检查：
- [ ] 背景图正确加载显示
- [ ] 各层以不同速度移动
- [ ] 水平移动时无缝循环（无断裂）
- [ ] 层次感明显，有深度效果
- [ ] 与前景角色和平台协调

---

## 🎓 学习要点

通过这个视差系统，你可以学习到：
1. **Godot Parallax2D 机制**
   - ParallaxBackground 容器
   - ParallaxLayer 独立控制
   - motion_scale 和 motion_mirroring 的作用

2. **视觉深度营造**
   - 多层叠加原理
   - 速度与距离的关系
   - 像素艺术背景设计

3. **资源管理**
   - Texture2D 引用
   - 场景外部资源链接
   - 素材复用策略

---

## 🔄 更新历史

**2026-05-13**
- ✅ 完成 level_01.tscn 视差层升级
- ✅ 完成 level_02.tscn 视差层升级
- ✅ 从 3 层 ColorRect 升级到 6 层 Sprite2D
- ✅ 使用项目中的实际背景素材

---

_小虾 🦐 提示：可以在 Godot 编辑器中实时预览视差效果，按 F6 运行关卡查看！_
