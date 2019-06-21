extends Area2D
class_name AttackArea

var attack_resource
var angle

func set_angle(vec):
	rotation = vec.angle()
	angle = vec

func attack_successful(entity):
	pass

func set_attack_resource(resource):
	attack_resource = resource