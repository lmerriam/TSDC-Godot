extends State

func enter():
	print("Start cast")

func update(delta):
	if entity.is_casting == false:
		transition_to("Idling")

func exit():
	print("End cast")
