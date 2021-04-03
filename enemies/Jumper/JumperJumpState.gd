extends State

var target_pos

func enter():
	owner.play_animation("JumperJumpAnimation")
	target_pos = owner.target.global_position

func update(delta):
	owner.velocity = (target_pos - owner.global_position).normalized() * 5
	if owner.global_position.distance_to(target_pos) <= 8:
		transition_to(next_state)

func exit():
	pass
