extends State

var attack_timer = 0
var attack_speed = 1

func update(delta):
	
	if !entity.in_attack_range:
		emit_signal("finished", "chase")
	
	attack_timer -= delta
	if attack_timer <= 0:
		print("attacking!")
		attack_timer = 1