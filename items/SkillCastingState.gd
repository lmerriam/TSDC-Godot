extends State

func enter():
	print("Start cast")

func update(delta):
	print("Casting")
	if entity.is_casting == false:
		emit_signal("finished","idle")

func exit():
	print("End cast")