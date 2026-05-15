# 🚀 完善版快速开始指南

## ✨ 新增功能概览

本项目已全面升级！现在包含：
- ✅ 完整的 UI 系统（生命值、金币显示）
- ✅ 2个可玩关卡（带关卡过渡）
- ✅ 增强的敌人 AI（巡逻+追踪）
- ✅ 终点旗帜胜利条件
- ✅ 音效管理框架
- ✅ 代码规范化

---

## 📋 5分钟快速测试

### 步骤 1: 打开项目
```
1. 启动 Godot 4.6
2. 导入项目（选择 project.godot）
3. 等待资源导入完成
```

### 步骤 2: 运行游戏
```
方法 A: 直接运行项目 (F5)
方法 B: 运行 level_01.tscn (F6)
```

### 步骤 3: 测试功能
```
🎮 基础操作
- A/D 或 ←/→ : 移动
- W/↑/空格 : 跳跃

❤️ 生命系统
- 碰到尖刺会扣血
- UI 左上角显示剩余生命
- 生命为 0 时死亡重生

💰 收集金币
- 在场景中添加 coin.tscn
- 接触后金币数增加
- UI 实时更新

🏁 通关测试
- 到达绿色终点旗帜
- 等待 1 秒
- 自动切换到 level_02
```

---

## 🎯 核心文件说明

### 必须了解的场景
```
scenes/level_01.tscn    - 第一关（入门级）
scenes/level_02.tscn    - 第二关（进阶级）
scenes/player.tscn      - 玩家预制件
scenes/hud.tscn         - UI 界面
scenes/coin.tscn        - 金币预制件
```

### 核心脚本
```
scripts/player.gd           - 玩家控制（移动、跳跃、战斗）
scripts/hud.gd              - UI 管理（血量、金币显示）
scripts/enemy.gd            - 敌人 AI（巡逻、追踪）
scripts/flag.gd             - 终点旗帜（胜利条件）
scripts/level_manager.gd    - 关卡管理（重生、过渡）
scripts/game_constants.gd   - 游戏常量定义
```

---

## 🛠️ 常用操作指南

### 1. 在关卡中添加金币

**方法 A: 使用预制件（推荐）**
```
1. 打开 FileSystem 面板
2. 找到 scenes/coin.tscn
3. 拖拽到 2D 视图中
4. 调整位置
```

**方法 B: 手动创建**
```gdscript
# 在关卡脚本中
var coin = load("res://scenes/coin.tscn").instantiate()
coin.position = Vector2(100, -50)
add_child(coin)
```

### 2. 添加敌人

**巡逻型敌人**
```
1. 创建 CharacterBody2D 节点
2. 添加脚本 scripts/enemy.gd
3. 设置 enemy_type = "patrol"
4. 调整 patrol_distance
```

**追踪型敌人**
```
1. 同上创建敌人
2. 设置 enemy_type = "chase"
3. 设置 detect_range = 200
4. 设置 chase_speed = 80
```

### 3. 修改玩家参数

**在编辑器中调整**
```
1. 打开 scenes/player.tscn
2. 选中 Player 节点
3. Inspector 中修改导出变量：
   - speed: 移动速度（默认 200）
   - jump_velocity: 跳跃力度（默认 -400）
   - can_double_jump: 是否允许二段跳
```

**在代码中修改**
```gdscript
# player.gd 顶部
@export var speed: float = 250.0  # 改更快
@export var jump_velocity: float = -450.0  # 跳更高
```

### 4. 自定义关卡

**添加平台**
```
1. 创建 StaticBody2D 节点
2. 添加 CollisionShape2D 子节点
3. 设置形状为 RectangleShape2D
4. 调整位置和大小
5. 设置 collision_layer = 3
```

**添加陷阱**
```
1. 创建 Area2D 节点
2. 添加脚本 scripts/spike.gd
3. 添加 CollisionShape2D
4. 设置 collision_mask = 1
```

**添加检查点**
```
1. 创建 Area2D 节点
2. 添加脚本 scripts/checkpoint.gd
3. 添加 Sprite2D 显示标志
4. 设置 checkpoint_id
```

---

## 🎨 UI 定制

### 修改 HUD 样式

**改变颜色**
```
1. 打开 scenes/hud.tscn
2. 选中 HealthLabel
3. Inspector → Theme Overrides → Colors
4. 修改 font_color
```

**添加新元素**
```gdscript
# hud.gd 中添加
@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreLabel

func update_score(value: int) -> void:
    if score_label:
        score_label.text = "分数: %d" % value
```

### 显示自定义消息

```gdscript
# 在任何脚本中
var hud = get_tree().get_first_node_in_group("hud")
if hud and hud.has_method("show_message"):
    hud.show_message("自定义消息！", 3.0)
```

---

## 🔧 常见问题解决

### Q1: 运行后黑屏/看不到角色
**解决方案**:
```
1. 检查 Camera2D 是否正确配置
2. 确认玩家位置在相机范围内
3. 检查 AnimatedSprite2D 的 Sprite Frames 是否关联
```

### Q2: 玩家掉出地图
**解决方案**:
```
1. 确保地面有 CollisionShape2D
2. 检查 collision_layer 设置
3. 验证玩家的 collision_mask 包含地形层
```

### Q3: UI 不显示
**解决方案**:
```
1. 确认场景中添加了 HUD 实例
2. 检查 CanvasLayer 的 z_index
3. 验证 Label 节点路径正确
```

### Q4: 关卡不切换
**解决方案**:
```
1. 检查 Flag 节点是否有 flag.gd 脚本
2. 确认 LevelManager 的 next_level_scene 已设置
3. 查看控制台是否有错误信息
```

### Q5: 敌人不移动
**解决方案**:
```
1. 确认敌人脚本已附加
2. 检查 enemy_type 设置
3. 验证 patrol_distance > 0
```

---

## 📊 性能优化建议

### 1. 启用对象池
```gdscript
# 对于频繁创建的物体（子弹、特效）
# 预先创建一批对象，重复使用而非销毁重建
```

### 2. 使用 VisibleOnScreenNotifier2D
```
1. 为敌人添加此节点
2. 离开屏幕时禁用物理处理
3. 减少不必要的计算
```

### 3. 纹理优化
```
1. 使用合适的纹理压缩格式
2. 避免过大的精灵图
3. 启用 Mipmap（3D）
```

---

## 🎓 扩展学习

### 推荐阅读顺序
```
1. PROJECT_IMPROVEMENTS.md  - 了解所有改进
2. PLAYER_SETUP.md          - 玩家动画配置
3. LEVEL_SETUP.md           - 关卡设计指南
4. QUICK_START.md           - 原始快速开始
```

### 进阶主题
```
✓ 实现射击系统（已有 Shoot 动画素材）
✓ 添加粒子特效（VFX 素材已就绪）
✓ 设计 Boss 战
✓ 实现存档系统
✓ 创建主菜单
```

---

## 🐛 调试技巧

### 查看调试信息
```gdscript
# 在任何脚本中
print("玩家位置: ", global_position)
print("当前状态: ", current_state)
print("生命值: ", current_health)
```

### 使用 Godot 调试器
```
1. 运行游戏 (F5)
2. 点击编辑器底部的 "Debugger" 标签
3. 查看 Errors、Warnings、Output
```

### 性能监控
```
1. 运行时按 Ctrl+F2 打开性能监控
2. 查看 FPS、内存使用
3. 识别性能瓶颈
```

---

## 📞 获取帮助

### 检查清单
```
遇到问题时，依次检查：
□ 控制台是否有错误信息
□ 节点路径是否正确
□ 脚本是否成功附加
□ 导出变量是否配置
□ 碰撞层/遮罩是否匹配
□ 资源是否正确加载
```

### 常用命令
```gdscript
# 列出所有组
print(get_tree().get_groups())

# 查找节点
var player = get_tree().get_first_node_in_group("player")

# 检查信号连接
print(get_signal_connection_list("body_entered"))
```

---

## 🎉 开始你的冒险！

现在你已经掌握了所有基础知识，开始创造属于你的精彩关卡吧！

**提示**: 
- 先从修改现有关卡开始
- 逐步添加新功能
- 经常测试确保一切正常
- 参考示例代码和文档

**祝游戏开发愉快！** 🦐✨

---

_最后更新：2026-05-13_  
_版本：v2.0_
