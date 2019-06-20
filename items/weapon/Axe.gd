extends Weapon

export var damage = 2
export var attack_speed = 2
export var knockback = 600

func _init():
	item_name = "Axe"
	attack_area = preload("res://attacks/Slash.tscn")
	set_stats_base({"damage": damage, "attack_speed": attack_speed, "knockback": knockback})

func attack():
	if !on_cooldown():
		var resource = AttackResource.new("player", stats.damage, stats.knockback, buffs)
		
		var mouse_pos = get_global_mouse_position()
		var angle = global_position.angle_to_point(mouse_pos)
		var atk = _create_attack_area(resource, Global.player_character, angle)
		
		set_cooldown(stats.attack_speed)