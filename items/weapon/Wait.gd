extends State

export var time := 1.0
export var cancelable = true
var time_current

func enter():
	time_current = time

func update(delta):
	time_current -= delta
	if time_current <= 0:
		transition_to(next_state)
	elif cancelable and !owner.owner_is_attacking:
		get_parent().transition_to("Idling")
