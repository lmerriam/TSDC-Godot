extends Area2D

var speed = 300
var angle = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position += Vector2(-(cos(angle) * speed * delta), -(sin(angle) * speed * delta))	
