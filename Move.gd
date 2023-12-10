extends State


@export var fall_state: State
@export var idle_state: State
@export var jump_state: State
@export var stop_state: State

func process_input(_event: InputEvent) -> State:
	
	if Input.is_action_just_pressed('jump') and parent.is_on_floor():
		return jump_state
		
	return null

func process_physics(delta: float) -> State:
	if stop_signal:
		return stop_state
	parent.velocity.y += gravity * delta
	#remove move left function
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement == 0:
		return idle_state
	
	parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null


func stop_player():

	stop_signal = true
	start_signal = false
	
func start_player():

	stop_signal = false
	start_signal = true
