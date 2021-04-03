extends State

func update(delta):
	if !owner.in_attack_range:
		get_parent().transition_to( "Wander")
	else:
		transition_to( next_state)
