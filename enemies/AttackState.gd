extends StateMachine

func update(delta):
	if !owner.in_attack_range:
		emit_signal("finished", "Chase")
