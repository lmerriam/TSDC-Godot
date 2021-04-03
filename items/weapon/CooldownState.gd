extends State

export var cancel_state := "Idling"

func update(delta):
	if not owner.owner_is_attacking:
		get_parent().transition_to(cancel_state)
	elif not owner.on_cooldown():
		transition_to(next_state)
		owner.start_cooldown()
