extends State

func update(delta):
	if not entity.is_attacking:
		emit_signal("finished","idle")
		
	elif not entity.on_cooldown():
		var atk = entity.item_owner.create_attack()
		var angle = entity._get_vector_to_mouse()
		var area = entity._create_attack_area(atk, Global.player, angle)
		area.global_position = entity.global_position
		
		entity.set_cooldown(atk.attack_speed)