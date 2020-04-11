extends StateMachine

func enter():
	.enter()
	owner.emit_signal("move_speed_modifier_updated", owner.move_speed_modifier)

func exit():
	owner.emit_signal("move_speed_modifier_updated", 1)
