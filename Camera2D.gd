extends Camera2D

export var zoom_default = Vector2(.5,.5)

export var max_offset : float = 5.0
export var max_roll : float = 25.0
export var shakeReduction : float = 2.5

var stress : float = 0.0
var shake : float = 0.0
var angle : float = 0.0
var center : Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	zoom = zoom_default
	Global.camera = self

func _unhandled_input(event):
	if Input.is_action_pressed("zoom_in"):
		zoom -= Vector2(.1,.1)
	if Input.is_action_pressed("zoom_out"):
		zoom += Vector2(.1,.1)
	if Input.is_action_pressed("reset_zoom"):
		zoom = zoom_default

func _process(delta):
	shake = stress * stress

	rotation_degrees = angle + (max_roll * shake *  _get_noise(randi(), delta))
#	if rotation_degrees > 0:
#		print(rotation_degrees)
	
	var offset = Vector2()
	offset.x = (max_offset * shake * _get_noise(randi(), delta + 1.0))
	offset.y = (max_offset * shake * _get_noise(randi(), delta + 2.0))
	
	offset_h = center.x + offset.x
	offset_v = center.y + offset.y
		
	stress -= (shakeReduction / 100.0)
	
	stress = clamp(stress, 0.0, 1.0)

func _get_noise(noise_seed, time) -> float:
	var n = OpenSimplexNoise.new()
	
	n.seed = noise_seed
	n.octaves = 4
	n.period = 20.0
	n.persistence = 0.8
	
	return n.get_noise_1d(time)

func add_stress(amount : float) -> void:
	stress += amount
	stress = clamp(stress, 0.0, 1.0)
