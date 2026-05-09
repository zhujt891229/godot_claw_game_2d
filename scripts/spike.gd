extends Area2D

## 尖刺/陷阱脚本
## 玩家接触后造成伤害或死亡

@export var damage: int = 1
@export var kill_on_touch: bool = true


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if kill_on_touch:
			body.die()
		else:
			# 计算击退方向
			var knockback_dir = sign(body.global_position.x - global_position.x)
			if knockback_dir == 0:
				knockback_dir = -1
			body.take_damage(damage, knockback_dir)
