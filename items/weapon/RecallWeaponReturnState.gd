extends State

func update(delta):
	if owner.active_attack_areas.size() <= 0:
		transition_to("Cooldown")
