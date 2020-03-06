extends AttackArea
class_name Slash

var time_left = .1

func _process(delta):
	if time_left <= 0:
		call_deferred("queue_free")
	time_left -= delta

func calc_knockback(body):
	var angle = Global.player.global_position.angle_to_point(body.global_position)
	var kb = -Vector2(cos(angle), sin(angle)) * properties.knockback
	return kb
