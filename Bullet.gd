extends Area2D

export var speed = 400
export var damage = 6
var angle = Vector2(0,0)
var time_left = 1
var creator

func _ready():
	set_as_toplevel(true)

func _process(delta):
	global_position += -Vector2((cos(angle) * speed * delta), (sin(angle) * speed * delta))
	time_left -= delta
	if time_left <= 0:
		queue_free()

func _on_Bullet_area_entered(area):
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()

func _on_Bullet_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()

func set_creator(group):
	creator = group
	return creator