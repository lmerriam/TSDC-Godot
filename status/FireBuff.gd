extends Buff
class_name FireBuff

func _init(_properties={"damage":4,"duration":4}):
	properties = _properties
	status = FireStatus
	type = "Fire"
	description = "Deals " + String(properties.damage) + " damage over " + String(properties.duration) + " sec"