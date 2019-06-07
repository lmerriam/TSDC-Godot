class_name Buff

var status
var properties
var prototype
var desc

func _init(_status, _properties):
	status = _status
	properties = _properties
	prototype = status.new(Global.player, self, properties.duplicate())
	desc = prototype.desc
	prototype.set_process(false)

func get_status():
	return status

func apply_to(inst):
	
	# Check for existing status from this buff
	var status_already_exists = false
	var s_existing = inst.get_status_current()
	for s in s_existing:
		if s.creator == self:
			status_already_exists = true
			s.properties = properties.duplicate()
	
	# Add new status
	if not status_already_exists:
		var s_new = status.new(inst, self, properties.duplicate())
		inst.add_status(s_new)