extends Node
class_name Status

var properties = {"duration": null}
var instance
var desc = ""
var type = "Status"
var creator

# TODO: we shouldn't have to instantiate an unused status just to get it's description for the buff
# Consider passing shared buff/status properties around through a wrapper object that contains stats and description
func init(_instance, _creator, _properties):
	instance = _instance
	creator = _creator
	properties = _properties
	start()

func start():
	set_process(true)

func remove():
	queue_free()
	instance.remove_status(self)

func expire():
	remove()