extends State

export var reverse := false
export var cancelable := true
export var attack_area = preload("res://attacks/Slash.tscn")

var canceled := false

func enter():
	canceled = false
	var angle = owner.aim_force
	var atk = owner.item_owner.create_attack()
	var area = owner._create_attack_area(atk, entity, angle)
	
	if reverse:
		(area as AttackArea).scale.y = -1
	
	area.connect("tree_exited", self, "on_attack_complete")

func update(delta):
	if not owner.owner_is_attacking:
		canceled = true

func on_attack_complete():
	if canceled:
		get_parent().transition_to("Idling")
	else:
		transition_to( next_state)
