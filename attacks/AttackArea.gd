extends Area2D
class_name AttackArea

var attack_resource
var angle

func set_angle(_angle):
	rotation_degrees = rad2deg(_angle) - 180
	angle = _angle

func attack_successful(entity):
	pass

func set_attack_resource(resource):
	attack_resource = resource