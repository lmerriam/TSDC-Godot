extends State

func update(delta):
	if entity.owner_is_attacking:
		transition_to( "Attacking")
