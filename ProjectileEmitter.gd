extends Node2D
class_name ProjectileEmitter

export var projectile = preload("res://attacks/Explosion.tscn")
export (NodePath) var entity_path
export var angle := 0.0
export var count := 1

onready var entity = get_node(entity_path)

func emit():
	for i in count:
		var p = projectile.instance()
		Global.entities.add_child(p)
		p.global_position = global_position
		p.set_attack_properties(entity.create_attack())
