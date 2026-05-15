extends Node2D

## 关卡管理器
## 负责关卡加载、检查点、玩家重生等

@export var player_scene: PackedScene
@export var spawn_points: Array[Node2D] = []
@export var current_spawn_index: int = 0
@export var next_level_scene: PackedScene = null

var player: Node2D = null
var checkpoints: Array[Vector2] = []
var current_checkpoint: int = 0


func _ready() -> void:
	# 添加到组
	add_to_group("level_manager")
	
	# 自动查找出生点
	if spawn_points.is_empty():
		var points = get_tree().get_nodes_in_group("spawn_point")
		for point in points:
			spawn_points.append(point)
	
	# 如果没有出生点，使用默认位置
	if spawn_points.is_empty():
		spawn_points.append(_create_default_spawn())
	
	# 生成玩家
	spawn_player()


func _create_default_spawn() -> Node2D:
	var spawn = Node2D.new()
	spawn.name = "DefaultSpawn"
	spawn.position = Vector2(-200, -50)
	add_child(spawn)
	return spawn


## 生成玩家
func spawn_player() -> void:
	if player:
		player.queue_free()
	
	if player_scene:
		player = player_scene.instantiate()
	else:
		# 使用默认玩家场景
		player = load("res://scenes/player.tscn").instantiate()
	
	var spawn_pos = spawn_points[current_spawn_index].global_position
	player.position = spawn_pos
	add_child(player)
	
	print("玩家在位置 %s 生成" % spawn_pos)


## 玩家死亡时调用
func on_player_death() -> void:
	if player:
		player.die()
	
	# 延迟后重生
	await get_tree().create_timer(1.5).timeout
	respawn_player()


## 在当前位置重生
func respawn_player() -> void:
	if player:
		player.queue_free()
	
	player = load("res://scenes/player.tscn").instantiate()
	var spawn_pos = spawn_points[current_spawn_index].global_position
	player.position = spawn_pos
	add_child(player)
	
	print("玩家在检查点重生")


## 设置新的检查点
func set_checkpoint(position: Vector2) -> void:
	# 检查是否已存在该检查点
	for checkpoint in checkpoints:
		if checkpoint.distance_to(position) < 10:
			return  # 已存在，不重复添加
	
	checkpoints.append(position)
	current_checkpoint = checkpoints.size() - 1
	print("设置新检查点：%d" % current_checkpoint)


## 获取当前检查点位置
func get_current_spawn_position() -> Vector2:
	if spawn_points.is_empty():
		return Vector2.ZERO
	return spawn_points[current_spawn_index].global_position


## 切换到下一个出生点
func next_spawn_point() -> void:
	current_spawn_index = (current_spawn_index + 1) % spawn_points.size()


## 切换到上一个出生点
func prev_spawn_point() -> void:
	current_spawn_index = (current_spawn_index - 1 + spawn_points.size()) % spawn_points.size()


## 关卡完成处理
func on_level_complete() -> void:
	print("关卡完成！")
	
	# 显示消息
	var hud = get_tree().get_first_node_in_group("hud")
	if hud and hud.has_method("show_message"):
		hud.show_message("关卡完成！", 2.0)
	
	# 延迟后切换关卡
	await get_tree().create_timer(2.0).timeout
	
	if next_level_scene:
		get_tree().change_scene_to_packed(next_level_scene)
	else:
		print("没有下一关，返回主菜单")
		# TODO: 返回主菜单
