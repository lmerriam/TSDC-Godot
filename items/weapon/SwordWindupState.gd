extends State

var windup_timer

func enter():
	print("Enter windup state")
	windup_timer = 0.2

func update(delta):
	windup_timer -= delta
	
	if windup_timer <= 0:
		emit_signal("finished", "swing")

func exit():
	print("Exit windup state")