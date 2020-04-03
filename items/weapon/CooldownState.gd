extends State

func enter():
	pass

func update(delta):
	if not owner.is_attacking:
		get_parent().emit_signal("finished","Idling")
	elif not owner.on_cooldown():
		emit_signal("finished",next_state)

func exit():
	pass
