extends Status
class_name CombustStatus

var atk = preload("res://attacks/Explosion.tscn")

func _on_entity_killed():
	
	var slash = atk.instance()
	slash.set_attack_properties({'faction': 'player', 'damage': 2, 'knockback': 900})
	
	Global.entities.call_deferred("add_child", slash)
	slash.global_position = entity.global_position