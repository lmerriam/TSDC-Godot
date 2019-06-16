extends Area2D
class_name AttackArea

var attack_resource

#func _init(resource):
#	attack_resource = resource

func _on_area_entered(entity):
	if entity.has_method("receive_attack"):
		if entity.receive_attack(attack_resource):
			_attack_successful(entity)

func _attack_successful(entity):
	pass

func set_attack_resource(resource):
	attack_resource = resource