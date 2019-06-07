extends Status
class_name FireStatus

var current_tick = 1

func _init(_instance, _creator, _properties):
	.init(_instance, _creator, _properties)
	type = "Fire"
	desc = "Deals " + String(properties.damage) + " damage over " + String(properties.duration) + " sec"

func _process(delta):
	properties.duration -= delta
	current_tick -= delta
	if properties.duration <= 0:
		expire()
	elif current_tick <= 0:
		instance.take_damage(properties.damage / properties.duration)
		current_tick = 1