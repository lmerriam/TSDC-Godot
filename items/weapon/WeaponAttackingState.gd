extends State

func update(delta):
	if not entity.on_cooldown():
		var stats = entity.stats
		var buffs = entity.buffs
		var atk = {}
		# TODO: rename "group" to faction
		atk.group = "player"
		atk.stats = stats.duplicate(true)
		atk.buffs = buffs.duplicate(true)
		
		var angle = entity._get_vector_to_mouse()
		var area = entity._create_attack_area(atk, Global.player, angle)
		area.global_position = entity.global_position
		
		entity.set_cooldown(stats.attack_speed)