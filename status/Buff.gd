class_name Buff

var properties
var type
var status
var description

func new_status(_entity, _group):
	return status.new(_entity, _group, self, properties.duplicate())