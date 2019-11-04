extends State

func update(delta):
	
	if !owner.in_attack_range:
		emit_signal("finished", "chase")
	
	if owner.attack_timer <= 0:
		
#		Attack and stuff
		var atk = owner.get_node("Entity").create_attack()
		owner.target.receive_attack(atk)
		
		owner.attack_timer = 1
		owner.stun_timer = .5
		
		emit_signal("finished", "stunned")