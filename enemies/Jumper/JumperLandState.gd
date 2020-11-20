extends "res://enemies/AnimateState.gd"

func enter():
	owner.find_node("ProjectileEmitter").emit()
	.enter()

func exit():
	owner.find_node("CollisionShape2D").set_deferred("disabled", false)
	.exit()
