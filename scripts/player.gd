extends CharacterBody2D

## 玩家控制脚本
## 适用于 Godot 4.x 2D 横版平台跳跃游戏
## 支持 AnimatedSprite2D 动画播放

# === 导出参数 (可在编辑器中调整) ===
@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 980.0
@export var coyote_time: float = 0.1  # 边缘缓冲时间
@export var jump_buffer_time: float = 0.1  # 跳跃缓冲时间

# === 状态变量 ===
var is_on_ground: bool = false
var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0
var is_dead: bool = false
var is_hurt: bool = false
var hurt_timer: float = 0.0

# === 节点引用 ===
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	# 更新计时器
	if coyote_timer > 0:
		coyote_timer -= delta
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta
	if hurt_timer > 0:
		hurt_timer -= delta
	else:
		is_hurt = false
	
	# 应用重力
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		coyote_timer = coyote_time  # 重置缓冲时间
	
	# 获取输入
	var direction := Input.get_axis("move_left", "move_right")
	
	# 跳跃缓冲
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time
	
	# 水平移动
	if direction:
		velocity.x = direction * speed
		# 翻转精灵朝向
		if animated_sprite:
			animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed * 0.2)
	
	# 跳跃 (使用缓冲和边缘时间)
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = jump_velocity
		jump_buffer_timer = 0
		coyote_timer = 0
	
	# 移动并检测碰撞
	move_and_slide()
	
	# 更新状态
	is_on_ground = is_on_floor()
	
	# 更新动画
	_update_animation(direction)


## 更新动画状态
func _update_animation(direction: float) -> void:
	if not animated_sprite:
		return
	
	if is_dead:
		animated_sprite.play("die")
	elif is_hurt:
		if not is_on_ground:
			animated_sprite.play("hit_jump")
		else:
			animated_sprite.play("hit_stand")
	elif not is_on_floor():
		animated_sprite.play("jump")
	elif direction != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")


## 受到伤害
func take_damage(amount: int, knockback_direction: float = 0) -> void:
	if is_dead or is_hurt:
		return
	
	is_hurt = true
	hurt_timer = 0.5  # 受伤无敌时间 0.5 秒
	
	# 添加击退
	if knockback_direction != 0:
		velocity.x = knockback_direction * 300
		velocity.y = -200
	
	# TODO: 实现血量系统
	print("玩家受到 %d 点伤害" % amount)
	
	_update_animation(0)


## 死亡
func die() -> void:
	if is_dead:
		return
	
	is_dead = true
	velocity = Vector2.ZERO
	collision_shape.set_deferred("disabled", true)  # 禁用碰撞
	
	if animated_sprite:
		animated_sprite.play("die")
	
	print("玩家死亡")


## 重置玩家位置
func reset_position(position: Vector2) -> void:
	self.position = position
	velocity = Vector2.ZERO
	is_dead = false
	is_hurt = false
	collision_shape.disabled = false
	
	if animated_sprite:
		animated_sprite.play("idle")


## 设置动画速度 (可选)
func set_animation_speed(animation_name: String, fps: float) -> void:
	if animated_sprite and animated_sprite.sprite_frames.has_animation(animation_name):
		animated_sprite.sprite_frames.set_animation_speed(animation_name, fps)
