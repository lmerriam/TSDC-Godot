extends State

export var next_state := "Recall"

func update(delta):
	if owner.is_attacking:
		if recall():
			emit_signal("finished",next_state)

func recall():
	for area in owner.active_attack_areas:
		if area.has_method("recall"):
			return area.recall(owner)
		else:
			return false
