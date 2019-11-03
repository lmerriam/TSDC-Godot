extends Node
class_name Buff

var properties
var type
var status
var description
var faction

func new_status(_entity):
	var s = status.new()
	s.init(_entity, self, properties.duplicate())
	_entity.add_child(s)
	return s