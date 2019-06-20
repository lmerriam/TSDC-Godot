extends Status
class_name ColdStatus

func _process(delta):
	properties.duration -= delta
	if properties.duration <= 0:
		expire()

func start():
	.start()
	entity.modulate = Color(.5,.5,1)
	entity.add_modifier("speed", self, properties.amount)

func remove():
	.remove()
	entity.remove_modifier("speed", self)
	entity.modulate = Color(1,1,1)