extends Area2D
class_name AttackArea

var properties
var angle = Vector2(0,0)

func set_angle(vec):
	rotation = vec.angle()
	angle = vec

func attack_successful(entity):
	pass

func set_attack_properties(props):
	properties = props
