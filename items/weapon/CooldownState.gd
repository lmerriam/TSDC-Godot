extends State

export var cancel_state := "Idling"

func update(delta):
	if not owner.owner_is_attacking:
		get_parent().emit_signal("finished",cancel_state)
	elif not owner.on_cooldown():
		emit_signal("finished",next_state)
		owner.start_cooldown()
