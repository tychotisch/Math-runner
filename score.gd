extends Control

@onready var score_label: Label = $Label
@onready var difficulty_timer: Timer = $DifficultyTimer

var score := 0
var amount := 1

func _ready() -> void:
	Event.connect("add_score", add_score)
	score_label.set_text("Score: " + str(score))

func add_score(value):
	score += value
	score_label.set_text("Score: " + str(score))

func _on_difficulty_timer_timeout() -> void:
	Event.emit_signal("increase_difficulty", amount)
