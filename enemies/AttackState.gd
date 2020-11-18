extends StateMachine

func update(delta):
	if !owner.in_attack_range:
		emit_signal("finished", "Chase")

func exit():
	owner.find_node("AnimatedSprite").animation = "default"
	owner.find_node("CollisionShape2D").set_deferred("disabled", false)
	.exit()
