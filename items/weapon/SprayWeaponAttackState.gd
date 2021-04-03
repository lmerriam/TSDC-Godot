extends State

func enter():
	pass

func update(delta):
	if not owner.owner_is_attacking:
		transition_to("Idling")
	
	

func exit():
	pass
