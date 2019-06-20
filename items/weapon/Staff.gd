extends Weapon

export var damage = 2
export var attack_speed = 5

func _init():
	item_name = "Staff"
	attack_area = preload("res://attacks/Bullet.tscn")
	set_stat_base("damage", damage)
	set_stat_base("attack_speed", attack_speed)
	add_buff_base(ColdBuff.new({"duration": 4, "amount": .5}))

func attack():
	if !on_cooldown():
		
		var resource = AttackResource.new("player", stats.damage, 0, buffs)
		var mouse_pos = get_global_mouse_position()
		var angle = global_position.angle_to_point(mouse_pos)
		var atk = _create_attack_area(resource, Global.entities, angle, Global.player_character.global_position)
		
		set_cooldown(stats.attack_speed)