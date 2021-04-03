extends State

export var attack_area = preload("res://attacks/Slash.tscn")
export var angle_vary := 0.0

func enter():
	var area = attack_area.instance()
	
	var angle = owner.aim_force.rotated(rand_range(-angle_vary,angle_vary))
	area.set_angle(angle)
	area.set_attack_properties(owner.item_owner.create_attack())
	owner.add_child(area)
	area.global_position = owner.global_position
	
	transition_to( next_state)
