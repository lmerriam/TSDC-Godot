extends Node2D
class_name Status

var entity
var buff
var properties
var group

signal expired

# TODO: we shouldn't have to instantiate an unused status just to get it's description for the buff
# Consider passing shared buff/status properties around through a wrapper object that contains stats and description
func init(_entity, _group, _buff, _properties):
	buff = _buff
	group = _group
	properties = _properties
	entity = _entity
	if entity.has_method("status_expired"):
		connect("expired", entity, "status_expired")
	start()

func start():
	set_process(true)

func remove():
	entity.remove_status(self)
	queue_free()

func expire():
	emit_signal("expired", self)
	remove()