extends Node2D
class_name Status

var entity
var buff
var properties

signal expired

# TODO: Change actor to entity
func init(_entity, _buff, _properties):
	buff = _buff
	properties = _properties
	entity = _entity
	
	connect("expired", entity, "_on_status_expired")
	entity.connect("killed", self, "_on_entity_killed")


func expire():
	emit_signal("expired", self)
	queue_free()


func _on_entity_killed():
	pass
