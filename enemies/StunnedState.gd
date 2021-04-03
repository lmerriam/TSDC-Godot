extends State

func enter():
	get_node('../../AnimatedSprite').playing = false
	get_node('../../CollisionShape2D').call_deferred("set_disabled", true)

func update(delta):
	owner.stun_timer -= delta
	if owner.stun_timer <= 0:
		transition_to( "Wander")

func exit():
	get_node('../../AnimatedSprite').playing = true
	get_node('../../CollisionShape2D').call_deferred("set_disabled", false)
