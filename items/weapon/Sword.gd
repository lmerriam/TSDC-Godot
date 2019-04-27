extends Weapon

export var damage = 10
export var attack_speed = 2

var attack = preload("res://attacks/Slash.tscn")

var angle = Vector2(0,0)
var cooldown = 0.0

func _init():
	set_stat_base("damage", damage)
	set_stat_base("attack_speed", attack_speed)

func _ready():
	set_component(Items.instance_item("gemfire"))
	set_component(Items.instance_item("triggerfast"))

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
	s.set_angle(angle)
	s.set_global_position(global_position)
	s.damage = stats.damage
	
	# Reset cooldown timer
	cooldown = 1.0 / stats.attack_speed