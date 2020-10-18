extends State

export var duration := 0.5

func update(delta):
	var atk = owner.get_node("Entity").create_attack()
	owner.target.receive_attack(atk)
	
	owner.attack_timer = 1
	owner.stun_timer = .5
	
	get_parent().emit_signal("finished", "Stunned")
