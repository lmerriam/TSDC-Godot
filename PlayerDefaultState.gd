extends State

func enter():
	pass

func update(delta):
	owner.process_movement()
	owner.process_aim()

func exit():
	pass
