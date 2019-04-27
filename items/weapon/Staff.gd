extends Weapon

export var damage = 1
export var attack_speed = 5

var cooldown = 0.0

var attack = preload("res://Bullet.tscn")

func _init():
	set_stat_base("damage", damage)
	set_stat_base("attack_speed", attack_speed)

func _ready():
	set_component(ItemLibrary.instance_item("gemfire"))
	set_component(ItemLibrary.instance_item("triggerfast"))

func _process(delta):
	cooldown -= delta
	if Input.is_action_pressed("attack") and cooldown <= 0:
		_attack()

func _attack():
	#Instance projectile
	var b = attack.instance()
	add_child(b)
	
	# Point the projectile in the right direction
	var mouse_pos = get_global_mouse_position()
	var angle = global_position.angle_to_point(mouse_pos)
	b.angle = angle
	b.global_position = global_position
	b.damage = stats.damage
	
	# Reset cooldown timer
	cooldown = 1.0 / stats.attack_speed