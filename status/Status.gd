extends Node2D
class_name Status

var actor
var buff
var properties
var group

signal expired

# TODO: we shouldn't have to instantiate an unused status just to get it's description for the buff
# Consider passing shared buff/status properties around through a wrapper object that contains stats and description
func init(_actor, _group, _buff, _properties):
	buff = _buff
	group = _group
	properties = _properties
	actor = _actor
	if actor.get_node("Entity").has_method("status_expired"):
		connect("expired", actor.get_node("Entity"), "status_expired")
	start()

func start():
	set_process(true)

func remove():
	actor.get_node("Entity").remove_status(self)
	queue_free()

func expire():
	emit_signal("expired", self)
	remove()