extends Node2D
class_name Status

var entity
var buff
var properties
var group

signal expired

# TODO: Change actor to entity
func init(_entity, _group, _buff, _properties):
	buff = _buff
	group = _group
	properties = _properties
	entity = _entity
	
	connect("expired", entity, "_on_status_expired")
	entity.connect("killed", self, "_on_entity_killed")
	
	start()


func start():
	set_process(true)


func expire():
	emit_signal("expired", self)
	queue_free()


func _on_entity_killed():
	pass