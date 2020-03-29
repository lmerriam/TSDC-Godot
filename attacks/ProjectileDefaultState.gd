extends State

func enter():
	$"../../Sprite/AnimationPlayer".play("Spinning")

func update(delta):
	if owner.recalling:
		emit_signal("finished", "Recall")
	elif owner.speed <= 1:
		emit_signal("finished", "Stuck")
