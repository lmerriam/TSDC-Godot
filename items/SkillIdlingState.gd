extends State

func update(delta):
	if entity.is_casting:
		emit_signal("finished","cast")