extends Status
class_name ColdStatus

func _init(_instance, _creator, _properties):
	.init(_instance, _creator, _properties)
	_instance.add_child(self)
	type = "Cold"
	desc = "Slows by " + String((1 - properties.amount) * 100) + "% for " + String(properties.duration) + " seconds"

func _process(delta):
	properties.duration -= delta
	if properties.duration <= 0:
		expire()

func start():
	if instance.has_method("get_stats_component"):
		instance.get_stats_component().add_modifier("speed", self, properties.amount)

func remove():
	.remove()
	if instance.has_method("get_stats_component"):
		instance.get_stats_component().remove_modifier("speed", self)