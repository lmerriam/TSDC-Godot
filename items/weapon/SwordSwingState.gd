extends State

var swing_timer

func enter():
	print("Enter swing state...")
	swing_timer = 0.2

func update(delta):
	swing_timer -= delta
	
	if swing_timer <= 0:
		get_parent().emit_signal("finished","idle")

func exit():
	print("Exit swing state")