extends State

func update(delta):
	if not entity.on_cooldown():
		var stats = entity.stats
		var buffs = entity.buffs
		var atk = {}
		atk.faction = "player"
#		atk.stats = stats.duplicate(true)
		atk.damage = stats.damage
		atk.knockback = stats.knockback
		atk.stagger = stats.stagger
		atk.bleed = true
		atk.buffs = buffs.duplicate(true)
		
		var angle = entity._get_vector_to_mouse()
		var area = entity._create_attack_area(atk, Global.player, angle)
		area.global_position = entity.global_position
		
		entity.set_cooldown(stats.attack_speed)