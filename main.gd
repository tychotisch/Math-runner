extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var ground := preload("res://Background/ground.tscn")

var multiplier_ground := 4608
var counter := 1
var ground_height := 600


func _process(_delta: float) -> void:
	ground_position()

func ground_position():
	if player.position.x > multiplier_ground * counter - 1500:
		spawn_ground()

func spawn_ground():
	var ground_to_spawn = ground.instantiate()
	add_child(ground_to_spawn)
	ground_to_spawn.position.x = multiplier_ground * counter
	ground_to_spawn.position.y = ground_height
	counter += 1
