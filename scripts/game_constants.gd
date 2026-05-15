# Godot 4.6 2D 平台跳跃游戏 - 常量定义
# 用于统一管理游戏中的常量值

## 物理层定义
const PLAYER_LAYER = 1
const ENEMY_LAYER = 2
const TERRAIN_LAYER = 3
const COLLECTIBLE_LAYER = 4

## 玩家相关常量
const PLAYER_SPEED = 200.0
const PLAYER_JUMP_VELOCITY = -400.0
const PLAYER_GRAVITY = 980.0
const PLAYER_MAX_HEALTH = 3
const PLAYER_COYOTE_TIME = 0.1
const PLAYER_JUMP_BUFFER_TIME = 0.1
const PLAYER_MAX_JUMPS = 2

## 敌人相关常量
const ENEMY_PATROL_SPEED = 50.0
const ENEMY_CHASE_SPEED = 80.0
const ENEMY_DETECT_RANGE = 150.0
const ENEMY_DAMAGE = 1

## UI 相关常量
const HUD_MARGIN = 10
const MESSAGE_DURATION = 2.0

## 关卡相关常量
const LEVEL_BOUNDS_DEFAULT = Rect2(-1000, -500, 2000, 1000)
const CAMERA_BOUNDARY_MARGIN = Vector2(100, 50)
const CAMERA_SMOOTHING_SPEED = 5.0

## 收集物相关常量
const COIN_VALUE = 1
const HEART_VALUE = 1

## 动画相关常量
const ANIMATION_IDLE_SPEED = 8.0
const ANIMATION_RUN_SPEED = 12.0
const ANIMATION_JUMP_SPEED = 12.0
const ANIMATION_DIE_SPEED = 8.0

## 时间相关常量
const RESPAWN_DELAY = 1.5
const DEATH_ANIMATION_DURATION = 0.5
const HURT_INVINCIBILITY_TIME = 0.5

## 输入动作名称
const INPUT_MOVE_LEFT = "move_left"
const INPUT_MOVE_RIGHT = "move_right"
const INPUT_JUMP = "jump"

## 节点组名称
const GROUP_PLAYER = "player"
const GROUP_ENEMY = "enemy"
const GROUP_COLLECTIBLE = "collectible"
const GROUP_CHECKPOINT = "checkpoint"
const GROUP_LEVEL_MANAGER = "level_manager"
const GROUP_HUD = "hud"

## 场景路径
const SCENE_PLAYER = "res://scenes/player.tscn"
const SCENE_HUD = "res://scenes/hud.tscn"
const SCENE_COIN = "res://scenes/coin.tscn"
const SCENE_LEVEL_01 = "res://scenes/level_01.tscn"
const SCENE_LEVEL_02 = "res://scenes/level_02.tscn"

## 资源路径
const RESOURCE_PLAYER_SPRITES = "res://resources/player_sprites.tres"
const RESOURCE_TERRAIN_TILESET = "res://resources/terrain_tileset.tres"

## 音频路径（预留）
const AUDIO_JUMP = "res://assets/audio/jump.wav"
const AUDIO_COIN = "res://assets/audio/coin.wav"
const AUDIO_HURT = "res://assets/audio/hurt.wav"
const AUDIO_DIE = "res://assets/audio/die.wav"
