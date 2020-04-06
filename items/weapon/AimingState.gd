extends State

func update(delta):
	if !entity.is_attacking:
		var atk = entity.item_owner.create_attack()
		var angle = owner.aim_force
		var area = entity._create_attack_area(atk, entity, angle)
		area.global_position = owner.global_position
		owner.add_active_attack(area)
		area.connect("projectile_destroyed", owner, "remove_active_attack")
		
		emit_signal("finished",next_state)
