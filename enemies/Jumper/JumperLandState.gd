extends "res://enemies/AnimateState.gd"

func exit():
	owner.find_node("CollisionShape2D").set_deferred("disabled", false)
	.exit()
