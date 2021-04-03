extends State

func update(delta):
	if entity.is_casting:
		transition_to("Casting")
