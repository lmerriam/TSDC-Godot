extends State

func update(delta):
	if owner.attack_timer <= 0:
		transition_to( next_state)
