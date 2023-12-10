extends CharacterBody2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Question

var speed = 320.0
const JUMP_VELOCITY = -400.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction := 0
var answer := 0
var difficulty := 0
var dummy := 0
var range_a := 5
var range_b := 10

func _ready() -> void:
	randomize()
	update_difficulty()
	generate_random_question()
	generate_dummy_answer()
	generate_correct_answer()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	if is_on_floor():
		direction = 1
		if direction:
			velocity.x = lerp(0, int(direction * speed), 0.8)
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()

func generate_random_question():
	var a := randi() % range_a + 2
	var b := randi() % range_b + 5
	answer = a + b
	label.set_text(str(a) + " + " + str(b) + " =")

func update_difficulty():
	for i in difficulty:
		range_a += 5
		range_b += 5

func generate_dummy_answer():
	dummy = randi() % answer + 10
	if dummy == answer:
		dummy += 2
	Event.emit_signal("dummy_answer", dummy)

func generate_correct_answer():
	Event.emit_signal("correct_answer", answer)

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("platform"):
		animation.stop(true)
		set_physics_process(false)
	if body.is_in_group("ground"):
		animation.play("rolling")
	if body.name == "Player":
		Event.emit_signal("game_over")
		animation.stop(true)
		set_physics_process(false)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
