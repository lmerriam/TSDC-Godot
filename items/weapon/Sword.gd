extends Weapon

export var damage = 4
export var attack_speed = 2

func _init():
	item_name = "Sword"
	attack_area = preload("res://attacks/Slash.tscn")
	set_stat_base("damage", damage)
	set_stat_base("attack_speed", attack_speed)
	set_stat_base("knockback", 0)

func attack():
	if !on_cooldown():
		var resource = AttackResource.new("player", stats.damage, stats.knockback, buffs)
		
		var angle = _get_vector_to_mouse()
		var atk = _create_attack_area(resource, Global.player_character, angle)
		
		set_cooldown(stats.attack_speed)