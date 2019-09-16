extends State

func update(delta):
	var player_pos = Global.player_character.global_position
	
	if entity.in_attack_range:
		emit_signal("finished", "attack")
	elif entity.in_chase_range:
		entity.move_toward_point(player_pos)
	else:
		emit_signal("finished", "wander")