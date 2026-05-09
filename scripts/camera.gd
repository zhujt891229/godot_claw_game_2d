extends Camera2D

## 摄像机跟随脚本
## 可选：添加边界限制和延迟跟随

@export var follow_target: Node2D = null
@export var boundary_margin: Vector2 = Vector2(100, 50)
@export var smoothing_enabled: bool = true
@export var smoothing_speed: float = 5.0

var level_bounds: Rect2 = Rect2(-1000, -500, 2000, 1000)  # 关卡边界


func _ready() -> void:
	if follow_target == null:
		# 自动查找玩家节点
		follow_target = get_node_or_null("../../Player")


func _process(delta: float) -> void:
	if follow_target:
		var target_pos = follow_target.global_position
		
		if smoothing_enabled:
			global_position = global_position.lerp(target_pos, smoothing_speed * delta)
		else:
			global_position = target_pos
		
		# 限制摄像机边界
		global_position.x = clamp(global_position.x, 
			level_bounds.position.x + boundary_margin.x, 
			level_bounds.end.x - boundary_margin.x)
		global_position.y = clamp(global_position.y,
			level_bounds.position.y + boundary_margin.y,
			level_bounds.end.y - boundary_margin.y)


## 设置关卡边界
func set_level_bounds(rect: Rect2) -> void:
	level_bounds = rect
