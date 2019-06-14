extends Status
class_name ColdStatus

func _init(_entity, _group, _buff, _properties).(_entity, _group, _buff, _properties):
	pass

func _process(delta):
	properties.duration -= delta
	if properties.duration <= 0:
		expire()

func start():
	if entity.has_method("get_stats_component"):
		entity.get_stats_component().add_modifier("speed", self, properties.amount)

func remove():
	.remove()
	if entity.has_method("get_stats_component"):
		entity.get_stats_component().remove_modifier("speed", self)