extends State

export var next_state := "Cooldown"

func update(delta):
	if owner.active_attack_areas.size() <= 0:
		emit_signal("finished","Cooldown")
