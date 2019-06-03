extends Weapon

export var damage = 10
export var attack_speed = 2

var attack_obj = preload("res://attacks/Slash.tscn")

var angle = Vector2(0,0)
var cooldown = 0.0

func _init():
	item_name = "Sword"
	stats_component.set_stat_base("damage", damage)
	stats_component.set_stat_base("attack_speed", attack_speed)

func _ready():
	pass

func _process(delta):
	cooldown -= delta

func attack():
	if cooldown <= 0:
		# Swing the sword
		var s = attack_obj.instance()
		Global.entites.add_child(s)
		
		# Point the projectile in the right direction
		var mouse_pos = get_global_mouse_position()
		var angle = global_position.angle_to_point(mouse_pos)
		s.set_angle(angle)
		s.set_global_position(global_position)
		s.damage = stats_component.get_stat("damage")
		
		# Reset cooldown timer
		cooldown = 1.0 / stats_component.get_stat("attack_speed")