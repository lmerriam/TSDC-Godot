extends State

func update(delta):
	var target_pos = owner.target.global_position
	
	if owner.in_attack_range:
		transition_to( "Attack")
	elif owner.in_chase_range or owner.chase_timer >= 0:
		owner.move_toward_point(target_pos)
	else:
		transition_to( "Wander")
