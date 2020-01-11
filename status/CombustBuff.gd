class_name CombustBuff extends Buff

func _init(_properties={"damage": 5, "duration": 5}):
	properties = _properties
	status = CombustStatus
	type = "Combustion"
	description = "Explodes for " + String(properties.damage) + " when enemy dies within " + String(properties.duration) + " sec"