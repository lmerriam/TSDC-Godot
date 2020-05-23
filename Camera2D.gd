extends Camera2D

export var zoom_default = Vector2(.5,.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	zoom = zoom_default

func _unhandled_input(event):
	if Input.is_action_pressed("zoom_in"):
		zoom -= Vector2(.1,.1)
	if Input.is_action_pressed("zoom_out"):
		zoom += Vector2(.1,.1)
	if Input.is_action_pressed("reset_zoom"):
		zoom = zoom_default
