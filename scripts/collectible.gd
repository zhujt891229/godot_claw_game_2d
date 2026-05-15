extends Area2D

## 收集物脚本 (金币、道具等)

@export var value: int = 1
@export var collect_sound: AudioStream = null
@export var item_type: String = "coin"  # coin, heart, gem 等

signal collected(value: int)

var hud: Node = null


func _ready() -> void:
	# 连接信号
	body_entered.connect(_on_body_entered)
	
	# 查找 HUD
	hud = get_tree().get_first_node_in_group("hud")
	
	# 添加浮动动画
	if has_node("Sprite2D"):
		var tween = create_tween()
		tween.set_loops()
		tween.tween_property($Sprite2D, "position:y", -5.0, 0.8).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property($Sprite2D, "position:y", 0.0, 0.8).set_ease(Tween.EASE_IN_OUT)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collect()


func collect() -> void:
	# 发出收集信号
	collected.emit(value)
	
	# 更新 HUD
	if hud and hud.has_method("add_coins"):
		hud.add_coins(value)
	
	# TODO: 播放收集音效
	# if collect_sound:
	#     $AudioStreamPlayer2D.stream = collect_sound
	#     $AudioStreamPlayer2D.play()
	
	# 显示收集特效
	_show_collect_effect()
	
	# 移除收集物
	await get_tree().create_timer(0.1).timeout
	queue_free()


## 显示收集特效
func _show_collect_effect() -> void:
	# TODO: 添加粒子特效
	if has_node("Sprite2D"):
		var sprite = $Sprite2D
		var tween = create_tween()
		tween.tween_property(sprite, "scale", Vector2(1.5, 1.5), 0.1)
		tween.tween_property(sprite, "modulate:a", 0.0, 0.1)


## 设置收集物类型
func setup(item_value: int = 1) -> void:
	value = item_value
