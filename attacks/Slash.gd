extends AttackArea
class_name Slash

func calc_knockback(body):
	var angle = Global.player.global_position.angle_to_point(body.global_position)
	var kb = -Vector2(cos(angle), sin(angle)) * properties.knockback
	return kb


func _on_animation_finished(anim_name):
	call_deferred("queue_free")
