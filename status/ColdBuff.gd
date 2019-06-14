class_name ColdBuff extends Buff

func _init(_properties):
	properties = _properties
	status = ColdStatus
	type = "Cold"
	description = "Slows by " + String((1 - properties.amount) * 100) + "% for " + String(properties.duration) + " sec"