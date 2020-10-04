extends State

func update(delta):
	if owner.attack_timer <= 0:
		emit_signal("finished", next_state)
