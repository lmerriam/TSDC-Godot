extends Weapon

#export var damage = 12
#export var attack_speed = 1

func _init():
	item_name = "Bow"
	attack_area = preload("res://attacks/Bullet.tscn")
	set_stat_base("damage", damage)
	set_stat_base("attack_speed", attack_speed)
	set_stat_base("knockback", 1)

func attack():
	if !on_cooldown():
		
		var resource = AttackResource.new("player", stats.damage, 0, buffs)
		var angle = -_get_vector_to_mouse()
		var atk = _create_attack_area(resource, Global.entities, angle, Global.player_character.global_position)
		atk.scale = Vector2(3,.3)
		
		set_cooldown(stats.attack_speed)