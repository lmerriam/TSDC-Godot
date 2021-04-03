extends State

var swing_timer

func enter():
	swing_timer = 0.2
	var atk = entity.item_owner.create_attack()
	var angle = owner.aim_force
	var area = entity._create_attack_area(atk, entity, angle)

func update(delta):
	swing_timer -= delta
	
	if swing_timer <= 0:
		if owner.owner_is_attacking:
			transition_to("Cooldown")
		else:
			get_parent().transition_to( "Idling")

func exit():
	owner.start_cooldown()
	
