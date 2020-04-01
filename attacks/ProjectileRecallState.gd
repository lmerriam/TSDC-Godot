extends State

func enter():
	$"../../Sprite/AnimationPlayer".play("Spinning")
	owner.angle = owner.global_position.direction_to(owner.target_entity.global_position)
	owner.speed = 4
	owner.drag = 0

func update(delta):
	owner.angle = owner.global_position.direction_to(owner.target_entity.global_position)
	owner.speed = clamp(owner.speed*1.1, 0, 12)
	
	if entity.global_position.distance_to(entity.target_entity.global_position) <= owner.speed:
		owner.queue_free()
