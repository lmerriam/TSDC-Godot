extends State

func update(delta):
	if entity.in_aggro_range:
		emit_signal("finished", "chase")
	elif !entity.in_origin_range:
		entity.move_toward_point(entity.origin)