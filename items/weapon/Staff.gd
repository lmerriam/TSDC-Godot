extends Weapon

export var damage = 2
export var attack_speed = 5

var cooldown = 0.0

var attack_obj = preload("res://Bullet.tscn")

func _init():
	item_name = "Staff"
	stats_component.set_stat_base("damage", damage)
	stats_component.set_stat_base("attack_speed", attack_speed)

func _ready():
	equipment_component.set_equipped(ItemLibrary.instance_item("gemfire"))
#	equipment_component.set_equipment_slots(["component"])
#	pass
#	set_component(ItemLibrary.instance_item("gemfire"))
#	set_component(ItemLibrary.instance_item("triggerfast"))

func _process(delta):
	cooldown -= delta

func attack():
	if cooldown <= 0:
		var stats = stats_component.get_stats()
		
		#Instance projectile
		var b = attack_obj.instance()
		Global.entities.add_child(b)
		
		# Point the projectile in the right direction
		var mouse_pos = get_global_mouse_position()
		var angle = global_position.angle_to_point(mouse_pos)
		b.angle = angle
		b.global_position = global_position
		b.damage = stats.damage
		
		# Reset cooldown timer
		cooldown = 1.0 / stats.attack_speed