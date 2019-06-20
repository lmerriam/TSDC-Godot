class_name Buff

var properties
var type
var status
var description

func new_status(_entity, _group):
	var s = status.new()
	s.init(_entity, _group, self, properties.duplicate())
	return s