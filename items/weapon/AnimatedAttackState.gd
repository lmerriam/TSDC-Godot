extends State

export var reverse := false
export var cancelable := true
export var attack_area = preload("res://attacks/Slash.tscn")

func enter():
	var angle = owner.aim_force
	var atk = owner.item_owner.create_attack()
	var area = owner._create_attack_area(atk, entity, angle)
	
	if reverse:
		(area as AttackArea).scale.y = -1
	
	area.connect("tree_exited", self, "on_attack_complete")

func on_attack_complete():
	if not owner.is_attacking and cancelable:
		get_parent().emit_signal("finished","Idling")
	else:
		emit_signal("finished", next_state)
