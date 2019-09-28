extends State

func update(delta):
#	if Global.player.attacking == false:
#		emit_signal("finished","idle")
#
	if not entity.on_cooldown():
		var stats = entity.stats
		var buffs = entity.buffs
		var atk = {}
		# TODO: rename "group" to faction
		atk.group = "player"
		atk.stats = stats.duplicate(true)
		atk.buffs = buffs.duplicate(true)
		
		var angle = entity._get_vector_to_mouse()
		var area = entity._create_attack_area(atk, Global.player_character, angle)
		area.global_position = entity.global_position
		
		entity.set_cooldown(stats.attack_speed)