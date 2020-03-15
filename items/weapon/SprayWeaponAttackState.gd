extends State

func enter():
	pass

func update(delta):
	if not owner.is_attacking:
		emit_signal("finished","Idling")
	
	

func exit():
	pass
