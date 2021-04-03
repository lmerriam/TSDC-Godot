extends StateMachine

func update(delta):
	if !owner.in_attack_range:
		transition_to( "Chase")

