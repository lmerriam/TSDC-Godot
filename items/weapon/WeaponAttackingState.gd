extends State

var attacker

func update(delta):
	if not entity.on_cooldown():
#		var atk = attacker.stats.duplicate()
#
#		atk.buffs = attacker.buffs.duplicate(true)
#		atk.faction = attacker.faction
#		atk.bleed = true
		var atk = owner.create_attack()
		
		var angle = entity._get_vector_to_mouse()
		var area = entity._create_attack_area(atk, Global.player, angle)
		area.global_position = entity.global_position
		
		entity.set_cooldown(atk.attack_speed)