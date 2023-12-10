extends State

@export var move_state: State




func process_physics(delta: float) -> State:
	
	if !parent.is_on_floor():
		parent.velocity.y += (gravity * 3) * delta
		parent.move_and_slide()
	if start_signal:
		return move_state
	
	return null
	

func start_player():

	stop_signal = false
	start_signal = true

func stop_player():

	stop_signal = true
	start_signal = false
