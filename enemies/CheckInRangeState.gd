extends State

func update(delta):
	if !owner.in_attack_range:
		get_parent().emit_signal("finished", "Wander")
	else:
		emit_signal("finished", next_state)
