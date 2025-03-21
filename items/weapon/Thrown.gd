extends State

func update(delta):
	if owner.owner_is_attacking:
		if recall():
			transition_to(next_state)

func recall():
	for area in owner.active_attack_areas:
		if area.has_method("recall"):
			return area.recall(owner)
		else:
			return false
