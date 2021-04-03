extends State

var current_charge

func enter():
	current_charge = 0

func update(delta):
	if current_charge >= entity.charge_time:
		transition_to(next_state)
	
	current_charge += delta

func _calc_charge():
	var pct = current_charge / entity.charge_time
