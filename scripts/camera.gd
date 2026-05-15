extends Camera2D

## 摄像机跟随脚本（简化版）
## 使用 Godot 内置的 position_smoothing，只处理边界限制

@export var follow_target: Node2D = null
@export var boundary_margin: Vector2 = Vector2(100, 50)

var level_bounds: Rect2 = Rect2(-1000, -500, 2000, 1000)  # 关卡边界


func _ready() -> void:
	if follow_target == null:
		# 自动查找玩家节点
		follow_target = get_node_or_null("../../Player")
	
	# 启用内置平滑跟随
	position_smoothing_enabled = true
	position_smoothing_speed = 5.0


func _process(delta: float) -> void:
	if follow_target:
		# 只处理边界限制，让引擎处理平滑跟随
		var target_pos = follow_target.global_position
		
		# 计算边界
		var min_x = level_bounds.position.x + boundary_margin.x
		var max_x = level_bounds.end.x - boundary_margin.x
		var min_y = level_bounds.position.y + boundary_margin.y
		var max_y = level_bounds.end.y - boundary_margin.y
		
		# 限制目标位置在边界内
		var clamped_pos = Vector2(
			clamp(target_pos.x, min_x, max_x),
			clamp(target_pos.y, min_y, max_y)
		)
		
		# 直接设置为目标位置（内置 smoothing 会处理插值）
		global_position = clamped_pos


## 设置关卡边界
func set_level_bounds(rect: Rect2) -> void:
	level_bounds = rect
