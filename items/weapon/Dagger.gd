extends Weapon

#export var damage = 2
#export var attack_speed = 4

func _init():
	item_name = "Dagger"
	attack_area = preload("res://attacks/SmallStab.tscn")
	player_speed_modifier = .85
	set_stat_base("damage", damage)
	set_stat_base("attack_speed", attack_speed)
	set_stat_base("knockback", 1)

func attack():
	if !on_cooldown():
		var resource = AttackResource.new("player", stats.damage, stats.knockback, buffs)
		
		var angle = _get_vector_to_mouse()
		var atk = _create_attack_area(resource, Global.player_character, angle)
		
		set_cooldown(stats.attack_speed)