extends Weapon

export var damage = 20
export var attack_speed = 2

var attack = preload("res://Slash.tscn")

var angle = Vector2(0,0)
var cooldown = 0.0

func _ready():
	pass

func _process(delta):
	cooldown -= delta
	if Input.is_action_pressed("attack") and cooldown <= 0:
		_attack()

func _attack():
	# Swing the sword
	var s = attack.instance()
	add_child(s)
	
	# Point the projectile in the right direction
	var mouse_pos = get_global_mouse_position()
	var angle = global_position.angle_to_point(mouse_pos)
	s.angle = angle
	s.global_position = global_position
	s.damage = damage
	
	# Reset cooldown timer
	cooldown = 1.0 / attack_speed