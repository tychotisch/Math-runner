class_name State
extends Node

@export var animation_name: String
@export var move_speed: float = 250
@export var jump_force: float = 700.0
## Hold a reference to the parent so that it can be controlled by the state
var parent: Player
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var start_signal := true
var stop_signal := false

func enter() -> void:
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_delta: float) -> State:
	return null

func process_physics(_delta: float) -> State:
	return null

func _ready() -> void:
	Event.connect("start_player", start_player)
	Event.connect("stop_player", stop_player)

func start_player():
	pass

func stop_player():
	pass

