extends State

var target_pos

func enter():
	owner.play_animation("JumperJumpAnimation")
	target_pos = owner.target.global_position

func update(delta):
	owner.velocity = (target_pos - owner.global_position).normalized() * 3
	if owner.global_position.distance_to(target_pos) <= 12:
		emit_signal("finished",next_state)

func exit():
	pass
