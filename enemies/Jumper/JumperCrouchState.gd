extends "res://enemies/AnimateState.gd"

func enter():
	.enter()
	owner.find_node("CollisionShape2D").set_deferred("disabled", true)
