extends Status
class_name ColdStatus

func _process(delta):
	properties.duration -= delta
	if properties.duration <= 0:
		expire()

func start():
	.start()
	actor.modulate = Color(.5,.5,1)
	actor.get_node("Entity").add_modifier("speed", self, properties.amount)

func remove():
	.remove()
	actor.get_node("Entity").remove_modifier("speed", self)
	actor.modulate = Color(1,1,1)