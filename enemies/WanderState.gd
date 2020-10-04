extends State

func update(delta):
	if owner.in_aggro_range or owner.chase_timer >= 0:
		emit_signal("finished", "Chase")
	
	if not owner.in_origin_range:
		owner.move_toward_point(owner.origin)
