extends State

func update(delta):
	if entity.in_aggro_range or entity.chase_timer >= 0:
		emit_signal("finished", "Chase")
	
	if not entity.in_origin_range:
		entity.move_toward_point(entity.origin)
