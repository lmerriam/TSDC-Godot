extends Node2D

export var damage = 1
export var attack_speed = 5

var cooldown = 0.0

var bullet = preload("res://Bullet.tscn")

func _ready():
	pass

func _process(delta):
	
	cooldown -= delta
	
	if Input.is_action_pressed("attack") and cooldown <= 0:
		
		#Instance projectile
		var b = bullet.instance()
		add_child(b)
		
		# Point the projectile in the right direction
		var mouse_pos = get_global_mouse_position()
		var angle = global_position.angle_to_point(mouse_pos)
		b.angle = angle
		b.global_position = global_position
		
		# Reset cooldown timer
		cooldown = 1.0 / attack_speed