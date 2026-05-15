extends Area2D

## 子弹脚本
## 玩家发射的子弹，直线飞行，击中敌人后消失

@export var speed: float = 400.0  # 子弹飞行速度
@export var damage: int = 1       # 伤害值
@export var lifetime: float = 3.0 # 最大存在时间（秒）

var direction: int = 1  # 飞行方向：1=右，-1=左
var is_active: bool = true


func _ready() -> void:
	# 设置碰撞层和遮罩
	collision_layer = 4    # bullets 层
	collision_mask = 2     # enemies 层
	
	# 添加自身到 bullets 组
	add_to_group("bullets")
	
	# 设置存活时间
	get_tree().create_timer(lifetime).timeout.connect(_on_lifetime_expired)


func _physics_process(delta: float) -> void:
	if not is_active:
		return
	
	# 水平移动
	position.x += direction * speed * delta


## 初始化子弹（从对象池获取时调用）
func initialize(start_position: Vector2, shoot_direction: int) -> void:
	position = start_position
	direction = shoot_direction
	
	# 翻转精灵朝向
	var sprite: Sprite2D = $Sprite2D
	if sprite:
		sprite.flip_h = (shoot_direction < 0)


## 子弹停用（用于对象池）
func deactivate() -> void:
	is_active = false
	set_physics_process(false)
	set_process(false)
	visible = false


## 子弹激活
func activate() -> void:
	is_active = true
	set_physics_process(true)
	set_process(true)
	visible = true


## 存活时间到期
func _on_lifetime_expired() -> void:
	destroy()


## 碰撞处理 - 击中敌人
func _on_body_entered(body: Node2D) -> void:
	if not is_active:
		return
	
	if body.is_in_group("enemy"):
		# 对敌人造成伤害
		if body.has_method("take_damage"):
			body.take_damage(damage)
		
		print("子弹击中敌人，造成 %d 点伤害" % damage)
		destroy()
	
	# 碰到地形也消失
	if body.is_in_group("terrain"):
		destroy()


## 销毁子弹
func destroy() -> void:
	is_active = false
	
	# 简单处理：直接移除
	# TODO: 可以添加击中特效
	queue_free()
