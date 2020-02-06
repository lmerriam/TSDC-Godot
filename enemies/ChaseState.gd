extends State

func update(delta):
	var target_pos = owner.target.global_position
	
	if owner.in_attack_range:
		emit_signal("finished", "Attack")
	elif owner.in_chase_range or entity.chase_timer >= 0:
		owner.move_toward_point(target_pos)
	else:
		emit_signal("finished", "Wander")
