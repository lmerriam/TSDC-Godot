extends State

func update(delta):
	entity.stun_timer -= delta
	if entity.stun_timer <= 0:
		emit_signal("finished", "wander")