extends Node

## 音效管理器
## 集中管理游戏中的所有音效

var sound_enabled: bool = true
var music_enabled: bool = true
var volume: float = 1.0

# 音效字典（预加载）
var sounds: Dictionary = {}


func _ready() -> void:
	# 设置为全局单例
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# 预加载常用音效
	_preload_sounds()
	
	print("音效管理器已就绪")


## 预加载音效
func _preload_sounds() -> void:
	# TODO: 添加实际音效文件路径
	# sounds["jump"] = load("res://assets/audio/jump.wav")
	# sounds["coin"] = load("res://assets/audio/coin.wav")
	# sounds["hurt"] = load("res://assets/audio/hurt.wav")
	pass


## 播放音效
func play_sound(sound_name: String, pitch_scale: float = 1.0) -> void:
	if not sound_enabled:
		return
	
	if sounds.has(sound_name):
		var player = AudioStreamPlayer2D.new()
		player.stream = sounds[sound_name]
		player.pitch_scale = pitch_scale
		player.volume_db = linear_to_db(volume)
		
		add_child(player)
		player.play()
		
		# 播放完成后自动移除
		await player.finished
		player.queue_free()
	else:
		print_warning("音效未找到: " + sound_name)


## 播放音乐
func play_music(music_name: String, loop: bool = true) -> void:
	if not music_enabled:
		return
	
	# TODO: 实现背景音乐播放
	print("播放音乐: " + music_name)


## 停止所有音乐
func stop_music() -> void:
	# TODO: 停止背景音乐
	pass


## 设置音量
func set_volume(value: float) -> void:
	volume = clamp(value, 0.0, 1.0)


## 切换音效开关
func toggle_sound() -> void:
	sound_enabled = not sound_enabled
	print("音效: " + ("开启" if sound_enabled else "关闭"))


## 切换音乐开关
func toggle_music() -> void:
	music_enabled = not music_enabled
	print("音乐: " + ("开启" if music_enabled else "关闭"))


## 打印警告信息
func print_warning(message: String) -> void:
	if OS.is_debug_build():
		push_warning("[SoundManager] " + message)
