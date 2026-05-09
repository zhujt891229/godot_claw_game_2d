extends Area2D

## 检查点脚本
## 玩家接触后设置为重生点

@export var checkpoint_id: int = 0
@export var is_activated: bool = false

var level_manager: Node2D = null


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	# 自动查找关卡管理器
	level_manager = get_tree().get_first_node_in_group("level_manager")
	
	# 初始状态：未激活
	_update_visual()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_activated:
		activate()


## 激活检查点
func activate() -> void:
	is_activated = true
	_update_visual()
	
	# 通知关卡管理器
	if level_manager:
		level_manager.set_checkpoint(global_position)
	
	print("检查点 %d 已激活" % checkpoint_id)


## 更新视觉效果
func _update_visual() -> void:
	# TODO: 根据 is_activated 切换精灵
	# 激活：亮色/绿色
	# 未激活：暗色/灰色
	if has_node("Sprite2D"):
		var sprite = $Sprite2D as Sprite2D
		if is_activated:
			sprite.modulate = Color(1, 1, 0.5)  # 亮黄色
		else:
			sprite.modulate = Color(0.5, 0.5, 0.5)  # 灰色
