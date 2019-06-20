extends AttackArea

var time_left = .1
var damage
var knockback

func _process(delta):
	if time_left <= 0:
		queue_free()
	time_left -= delta

func calc_knockback(body):
	var angle = Global.player_character.global_position.angle_to_point(body.global_position)
	var kb = -Vector2(cos(angle), sin(angle)) * knockback
	return kb