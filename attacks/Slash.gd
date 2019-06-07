extends Attack

var time_left = .1
var damage
var knockback

func _process(delta):
	if time_left <= 0:
		queue_free()
	time_left -= delta

func _on_Slash_body_entered(body):
	if damage and body.has_method("take_damage"):
		body.take_damage(damage)
		for buff in buffs:
			buff.apply_to(body)
	if knockback and body.has_method("knockback"):
		body.knockback(calc_knockback(body))

func set_angle(angle):
	rotation_degrees = rad2deg(angle) - 180

func calc_knockback(body):
	var angle = Global.player.global_position.angle_to_point(body.global_position)
	var kb = -Vector2(cos(angle), sin(angle)) * knockback
	return kb