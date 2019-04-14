extends Area2D

export var speed = 400
export var damage = 6
var angle = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += -Vector2((cos(angle) * speed * delta), (sin(angle) * speed * delta))

func _on_Bullet_area_entered(area):
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()

func _on_Bullet_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
