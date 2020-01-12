extends State

func update(delta):
	if entity.is_attacking:
		emit_signal("finished", "Attacking")