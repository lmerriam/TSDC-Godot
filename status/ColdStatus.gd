extends Status
class_name ColdStatus

func _physics_process(delta):
	properties.duration -= delta
	if properties.duration <= 0:
		expire()

func _ready():
	entity.get_parent().modulate = Color(.5,.5,1)
	entity.add_modifier("speed", self, properties.amount)

func expire():
	entity.remove_modifier("speed", self)
	entity.get_parent().modulate = Color(1,1,1)
	.expire()
