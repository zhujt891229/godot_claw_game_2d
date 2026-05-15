extends CanvasLayer

## HUD (Heads-Up Display) 脚本
## 显示玩家血量、金币数、关卡信息等

@onready var health_label: Label = $MarginContainer/VBoxContainer/HealthLabel
@onready var coin_label: Label = $MarginContainer/VBoxContainer/CoinLabel
@onready var level_label: Label = $MarginContainer/VBoxContainer/LevelLabel
@onready var message_label: Label = $MessageLabel

var current_health: int = 3
var max_health: int = 3
var coin_count: int = 0
var current_level: String = "关卡 1"


func _ready() -> void:
	update_health_display()
	update_coin_display()
	update_level_display()
	
	# 隐藏消息标签
	if message_label:
		message_label.visible = false


## 更新血量显示
func update_health_display() -> void:
	if health_label:
		var hearts = ""
		for i in range(max_health):
			if i < current_health:
				hearts += "❤️ "
			else:
				hearts += "🖤 "
		health_label.text = "生命: " + hearts


## 更新金币显示
func update_coin_display() -> void:
	if coin_label:
		coin_label.text = "金币: %d" % coin_count


## 更新关卡显示
func update_level_display() -> void:
	if level_label:
		level_label.text = current_level


## 增加金币
func add_coins(amount: int = 1) -> void:
	coin_count += amount
	update_coin_display()


## 减少生命值
func take_damage(amount: int = 1) -> void:
	current_health -= amount
	if current_health < 0:
		current_health = 0
	update_health_display()
	
	if current_health <= 0:
		on_player_death()


## 恢复生命值
func heal(amount: int = 1) -> void:
	current_health += amount
	if current_health > max_health:
		current_health = max_health
	update_health_display()


## 设置最大生命值
func set_max_health(value: int) -> void:
	max_health = value
	current_health = value
	update_health_display()


## 显示临时消息
func show_message(text: String, duration: float = 2.0) -> void:
	if message_label:
		message_label.text = text
		message_label.visible = true
		
		await get_tree().create_timer(duration).timeout
		
		message_label.visible = false


## 玩家死亡处理
func on_player_death() -> void:
	show_message("游戏结束！", 2.0)
	# TODO: 触发重生或返回菜单


## 重置 HUD
func reset() -> void:
	current_health = max_health
	coin_count = 0
	update_health_display()
	update_coin_display()
