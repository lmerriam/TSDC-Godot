extends Area2D

var time_left = .1
var damage

func _ready():
	pass

func _process(delta):
	if time_left <= 0:
		queue_free()
	
	time_left -= delta

func _on_Slash_body_entered(body):
	if damage and body.has_method("take_damage"):
		body.take_damage(damage)

func set_angle(angle):
	rotation_degrees = rad2deg(angle) - 180