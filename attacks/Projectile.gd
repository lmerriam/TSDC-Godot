extends AttackArea

export var speed = 12
export var pierce := 1
export var drag := 0.0
export var drop := 0.0
export var deform := true
export var lifetime := 1.0

var time_left = lifetime
var drop_current = 0
var grounded_texture = load("res://sprites/pixeltier/bows/arrow_1_grounded.png")

func _ready():
	set_as_toplevel(true)

func _process(delta):
	time_left -= delta
	if time_left <= 0 or speed <= 2:
		
		var sprite = Sprite.new()
		Global.entities.add_child(sprite)
		sprite.global_position = global_position
		sprite.global_rotation = $Sprite.global_rotation
		sprite.texture = grounded_texture
		queue_free()

func _physics_process(delta):
	if deform:
		var x_scale = clamp(1 + speed*.05, 1, 2)
		var y_scale = 1 - (x_scale - 1)
		scale = Vector2(x_scale,1)
	
	if drag:
		speed -= drag
	
	if drop:
		drop_current = clamp(drop_current + .003, 0, drop)
		angle.y += drop_current
		global_rotation = angle.angle()
	
	global_position += (angle * speed)

func attack_successful(entity):
	pierce -= 1
	if pierce <= 0:
		queue_free()
