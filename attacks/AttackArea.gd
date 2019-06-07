extends Area2D
class_name AttackArea

var attack_resource

#func _init(resource):
#	attack_resource = resource

func _on_area_entered(entity):
	if attack_resource.transfer_attack(entity):
		return true

func set_attack_resource(resource):
	attack_resource = resource