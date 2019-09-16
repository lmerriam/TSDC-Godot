extends RigidBody2D

var velocity = Vector2(0,0)

func _integrate_forces(state):
	var t = state.get_transform()
	t.origin.x += velocity.x
	t.origin.y += velocity.y
	state.set_transform(t)
	
	velocity = Vector2(0,0)