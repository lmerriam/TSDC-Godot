extends State

func enter():
	get_node('../../AnimatedSprite').playing = false
	get_node('../../CollisionShape2D').call_deferred("set_disabled", true)

func update(delta):
	entity.stun_timer -= delta
	if entity.stun_timer <= 0:
		emit_signal("finished", "Wander")

func exit():
	get_node('../../AnimatedSprite').playing = true
	get_node('../../CollisionShape2D').call_deferred("set_disabled", false)