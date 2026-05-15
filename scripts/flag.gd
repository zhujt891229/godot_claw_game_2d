extends Area2D

## 终点旗帜脚本
## 玩家接触后触发胜利条件

@export var next_level_scene: PackedScene = null
@export var victory_message: String = "关卡完成！"

var level_manager: Node2D = null


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	# 自动查找关卡管理器
	level_manager = get_tree().get_first_node_in_group("level_manager")
	
	print("终点旗帜已就绪")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		victory()


## 胜利处理
func victory() -> void:
	print(victory_message)
	
	# 禁用碰撞防止重复触发
	set_deferred("monitoring", false)
	
	# 通知关卡管理器
	if level_manager:
		if level_manager.has_method("on_level_complete"):
			level_manager.on_level_complete()
	
	# 延迟后切换到下一关或显示胜利界面
	await get_tree().create_timer(1.0).timeout
	
	if next_level_scene:
		# 切换到下一关
		get_tree().change_scene_to_packed(next_level_scene)
	else:
		# 返回主菜单或显示胜利画面
		print("所有关卡完成！")
		# TODO: 显示胜利 UI


## 设置下一关场景
func set_next_level(scene: PackedScene) -> void:
	next_level_scene = scene
