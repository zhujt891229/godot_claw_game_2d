extends CharacterBody2D

## 基础敌人 AI 脚本
## 简单的巡逻行为

@export var speed: float = 50.0
@export var patrol_distance: float = 100.0
@export var gravity: float = 980.0

var start_position: Vector2
var direction: int = 1


func _ready() -> void:
	start_position = position


func _physics_process(delta: float) -> void:
	# 应用重力
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# 巡逻逻辑
	var target_x = start_position.x + (patrol_distance * direction)
	
	if abs(position.x - target_x) < 5.0:
		direction *= -1
	
	velocity.x = direction * speed
	
	move_and_slide()


func take_damage(amount: int) -> void:
	# TODO: 实现敌人受伤逻辑
	queue_free()  # 简单处理：直接删除


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	# 离开屏幕时停用
	set_process(false)


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	# 进入屏幕时启用
	set_process(true)
