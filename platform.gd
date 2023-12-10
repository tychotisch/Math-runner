extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var game_over_timer: Timer = $GameOver

@onready var correct_shape: CollisionShape2D = $CorrectDetection/CorrectShape
@onready var correct_label: Label = $CorrectDetection/Label
@onready var dummy_shape: CollisionShape2D = $DummyDetection/DummyShape
@onready var dummy_label: Label = $DummyDetection/Label
@onready var spawn_area: Area2D = $SpawnArea

var top_answer_pos := -62.5
var down_answer_pos := 136
var correct_answer 
var dummy_answer
var answer_list := []
var can_spawn := true

func _ready() -> void:
	randomize()
	Event.connect("dummy_answer", store_dummy_answer)
	Event.connect("correct_answer", store_correct_answer)

func store_dummy_answer(value):
	dummy_answer = value
	answer_list.append(value)

func store_correct_answer(value):
	correct_answer = value
	answer_list.append(value)
	display_answers()

func display_answers():
	answer_list.shuffle()
	dummy_label.set_text(str(answer_list[0]))
	correct_label.set_text(str(answer_list[1]))
	if answer_list[0] == correct_answer:
		dummy_shape.position.y = down_answer_pos
		correct_shape.position.y = top_answer_pos


#region Detection zones
func _on_correct_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Event.emit_signal("stop_player")
		animation_player.play("correct")
		Event.emit_signal("add_score", 1)


func _on_dummy_detection_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Event.emit_signal("stop_player")
		animation_player.play("game_over_anim")
		game_over_timer.start(2)


func _on_spawn_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and can_spawn:
		can_spawn = false
		dummy_label.queue_free()
		correct_label.queue_free()
		spawn_area.queue_free()
		Event.emit_signal("spawn_platform")
		Event.emit_signal("spawn_rock")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "correct":
		Event.emit_signal("start_player")
	if anim_name == "game_over_anim":
		Event.emit_signal("game_over")
	#endregion

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
