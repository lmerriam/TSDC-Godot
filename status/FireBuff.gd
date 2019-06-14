class_name FireBuff extends Buff

func _init(_properties):
	properties = _properties
	status = FireStatus
	type = "Fire"
	description = "Deals " + String(properties.damage) + " damage over " + String(properties.duration) + " sec"