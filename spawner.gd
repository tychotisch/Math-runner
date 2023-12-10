extends Node2D

@onready var player: Player = $"../Player"
var platform := preload("res://Platform/platform.tscn")
var rock := preload("res://Rock/rock.tscn")
var platform_offset := 750
var rock_offset := 0
var platform_level := 350
var difficulty := 0

#platform mus sopawn before rock

func _ready() -> void:
	Event.connect("spawn_platform", spawn_platform)
	Event.connect("spawn_rock", spawn_rock)
	Event.connect("increase_difficulty", set_difficulty)

func set_difficulty(amount):
	difficulty += amount

func spawn_platform():
	var new_platform = platform.instantiate()
	#add_child(new_platform)
	call_deferred("add_child", new_platform)
	new_platform.position.x = player.position.x + platform_offset
	new_platform.position.y = platform_level
	
func spawn_rock():
	var new_rock = rock.instantiate()
	#add_child(new_rock)
	call_deferred("add_child", new_rock)
	new_rock.difficulty = difficulty
	new_rock.position.x = player.position.x + rock_offset
