extends Weapon

export var damage = 2
export var attack_speed = 2
export var knockback = 600

var attack_obj = preload("res://attacks/Slash.tscn")

var angle = Vector2(0,0)
var cooldown = 0.0

func _init():
	item_name = "Axe"
	stats_component.set_stat_base("damage", damage)
	stats_component.set_stat_base("attack_speed", attack_speed)
	stats_component.set_stat_base("knockback", knockback)
	
	add_buff_base(ColdBuff.new({"duration": 4, "amount": .5}))
	
	equipment_component.set_equipped(ItemLibrary.instance_item("gemfire"))

func _process(delta):
	cooldown -= delta

func attack():
	if cooldown <= 0:
		var resource = AttackResource.new("player", stats_component.get_stat("damage"), stats_component.get_stat("knockback"), buffs)
		var slash = attack_obj.instance()
		slash.set_attack_resource(resource)
		
		# Add slash to 
		Global.entities.add_child(slash)
		var mouse_pos = get_global_mouse_position()
		var angle = global_position.angle_to_point(mouse_pos)
		slash.set_angle(angle)
		slash.set_global_position(global_position)
		
		# Reset cooldown timer
		cooldown = 1.0 / stats_component.get_stat("attack_speed")