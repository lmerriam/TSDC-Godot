extends State

export var attack_area = preload("res://attacks/Slash.tscn")

func enter():
	var area = attack_area.instance()
	area.set_angle(owner.aim_force)
	area.set_attack_properties(owner.item_owner.create_attack())
	owner.add_child(area)
	area.global_position = owner.global_position
	
	emit_signal("finished", next_state)
