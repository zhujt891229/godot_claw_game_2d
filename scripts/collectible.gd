extends Area2D

## 收集物脚本 (金币、道具等)

@export var value: int = 1
@export var collect_sound: AudioStream = null

signal collected(value: int)


func _ready() -> void:
	# 连接信号
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collect()


func collect() -> void:
	# 发出收集信号
	collected.emit(value)
	
	# TODO: 播放收集音效
	# if collect_sound:
	#     $AudioStreamPlayer2D.stream = collect_sound
	#     $AudioStreamPlayer2D.play()
	
	# 移除收集物
	queue_free()


## 设置收集物类型
func setup(item_value: int = 1) -> void:
	value = item_value
