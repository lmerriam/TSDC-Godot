extends Weapon

export var damage = 2
export var attack_speed = 2
export var knockback = 600

var attack = preload("res://attacks/Slash.tscn")

var angle = Vector2(0,0)
var cooldown = 0.0

func _init():
	item_name = "Axe"
	set_stat_base("damage", damage)
	set_stat_base("attack_speed", attack_speed)
	set_stat_base("knockback", knockback)

func _ready():
	pass
#	set_component(ItemLibrary.instance_item("gemfire"))
#	set_component(ItemLibrary.instance_item("triggerfast"))

func _process(delta):
	cooldown -= delta

func attack():
	if cooldown <= 0:
		var s = attack.instance()
		add_child(s)
		
		var mouse_pos = get_global_mouse_position()
		var angle = global_position.angle_to_point(mouse_pos)
		s.set_angle(angle)
		s.set_global_position(global_position)
		s.damage = stats.damage
		s.knockback = stats.knockback
		print(s.knockback)
		
		# Reset cooldown timer
		cooldown = 1.0 / stats.attack_speed