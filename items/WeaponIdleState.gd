extends State

func update(delta):
	if entity.owner_is_attacking:
		emit_signal("finished", "Attacking")
