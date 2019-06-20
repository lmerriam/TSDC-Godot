extends AttackArea

export var speed = 400
export var damage = 6
var time_left = 1

func _ready():
	set_as_toplevel(true)

func _process(delta):
	global_position += -Vector2((cos(angle) * speed * delta), (sin(angle) * speed * delta))
	time_left -= delta
	if time_left <= 0:
		queue_free()

func attack_successful(entity):
	queue_free()