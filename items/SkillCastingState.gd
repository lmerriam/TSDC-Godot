extends State

func enter():
	print("Start cast")

func update(delta):
	if entity.is_casting == false:
		emit_signal("finished","Idling")

func exit():
	print("End cast")