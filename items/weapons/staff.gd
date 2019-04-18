extends Node2D

export var damage = 1
export var attack_speed = 2

var attack_timer = 0
var bullet = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	attack_timer -= delta
	
	if Input.is_action_pressed("attack") and attack_timer <= 0:
		var b = bullet.instance()
		var mouse_pos = get_global_mouse_position()
		var angle = global_position.angle_to_point(mouse_pos)
		b.angle = angle
		b.global_position = global_position
		GameState.entities.add_child(b)
		attack_timer = 1 / attack_speed
		print(self)