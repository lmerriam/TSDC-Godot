extends State

func enter():
	$"../../Sprite/AnimationPlayer".play("Spinning")

func update(delta):
	if owner.recalling:
		transition_to( "Recall")
	elif owner.speed <= 1:
		transition_to( "Stuck")
