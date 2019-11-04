extends State

func update(delta):
	var target_pos = owner.target.global_position
	
	if owner.in_attack_range:
		emit_signal("finished", "attack")
	elif owner.in_chase_range:
		owner.move_toward_point(target_pos)
	else:
		emit_signal("finished", "wander")