extends CharacterBody2D

## 增强版敌人 AI 脚本
## 支持巡逻、追踪、攻击等行为

@export var speed: float = 50.0
@export var patrol_distance: float = 100.0
@export var gravity: float = 980.0
@export var damage: int = 1
@export var detect_range: float = 150.0  # 玩家检测范围
@export var chase_speed: float = 80.0  # 追踪速度
@export var enemy_type: String = "patrol"  # patrol, chase, fly

enum State { PATROL, CHASE, ATTACK, IDLE }
var current_state: State = State.PATROL

var start_position: Vector2
var direction: int = 1
var player: Node2D = null
var is_dead: bool = false

# === 节点引用 ===
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	start_position = position
	# 查找玩家
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	# 应用重力（飞行敌人除外）
	if enemy_type != "fly" and not is_on_floor():
		velocity.y += gravity * delta
	
	# 状态机
	match current_state:
		State.PATROL:
			_patrol()
		State.CHASE:
			_chase_player()
		State.IDLE:
			_idle()
	
	move_and_slide()
	
	# 检查是否检测到玩家
	_check_player_detection()


## 巡逻行为
func _patrol() -> void:
	var target_x = start_position.x + (patrol_distance * direction)
	
	if abs(position.x - target_x) < 5.0:
		direction *= -1
	
	velocity.x = direction * speed


## 追踪玩家
func _chase_player() -> void:
	if not player:
		current_state = State.PATROL
		return
	
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# 如果玩家太远，返回巡逻状态
	if distance_to_player > detect_range * 1.5:
		current_state = State.PATROL
		return
	
	# 朝玩家移动
	var dir_to_player = sign(player.global_position.x - global_position.x)
	velocity.x = dir_to_player * chase_speed


## 待机状态
func _idle() -> void:
	velocity.x = move_toward(velocity.x, 0, speed * 0.2)


## 检测玩家
func _check_player_detection() -> void:
	if not player or enemy_type == "patrol":
		return
	
	var distance_to_player = global_position.distance_to(player.global_position)
	
	if distance_to_player <= detect_range:
		if current_state != State.CHASE:
			current_state = State.CHASE
			print("敌人发现玩家！")


func take_damage(amount: int) -> void:
	if is_dead:
		return
	
	print("敌人受到 %d 点伤害" % amount)
	
	# TODO: 添加受伤动画和音效
	
	# 简单处理：直接死亡
	die()


## 死亡
func die() -> void:
	is_dead = true
	set_physics_process(false)
	
	# TODO: 播放死亡动画
	
	# 延迟后移除
	await get_tree().create_timer(0.5).timeout
	queue_free()


## 受伤箱碰撞处理
func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and not is_dead:
		# 对玩家造成伤害
		if body.has_method("take_damage"):
			body.take_damage(damage, sign(body.global_position.x - global_position.x))


## 攻击区域碰撞处理
func _on_attack_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and current_state == State.CHASE:
		# 播放攻击动画
		if animated_sprite and not animated_sprite.is_playing():
			animated_sprite.play("attack")


## 动画完成处理
func _on_animation_finished() -> void:
	if is_dead:
		return
	
	# 攻击动画完成后返回巡逻或追踪状态
	if animated_sprite and animated_sprite.animation == "attack":
		if player and global_position.distance_to(player.global_position) <= detect_range:
			current_state = State.CHASE
		else:
			current_state = State.PATROL
			animated_sprite.play("walk")


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	# 离开屏幕时停用
	set_physics_process(false)


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	# 进入屏幕时启用
	set_physics_process(true)
