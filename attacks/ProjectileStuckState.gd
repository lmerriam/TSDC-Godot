extends State

func enter():
	$"../../Sprite/AnimationPlayer".stop()
	owner.global_rotation = 0
	owner.get_node("Sprite").rotation_degrees = -70

func update(delta):
	if owner.recalling:
		emit_signal("finished","Recall")
