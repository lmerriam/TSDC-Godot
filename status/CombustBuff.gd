class_name CombustBuff extends Buff

func _init(_properties):
	properties = _properties
	status = CombustStatus
	type = "Combustion"
	description = "Explodes for " + String(properties.damage) + " when enemy dies within " + String(properties.duration) + " sec"