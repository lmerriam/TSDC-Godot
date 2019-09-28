extends Area2D
class_name AttackArea

var properties
var angle

func set_angle(vec):
	rotation = vec.angle()
	angle = vec

func attack_successful(entity):
	pass

func set_attack_properties(props):
	properties = props

func transfer_attack(entity):
	if entity.has_method("receive_attack"):
		if entity.receive_attack(properties):
			return true
	return false