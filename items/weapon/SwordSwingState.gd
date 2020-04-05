extends State

var swing_timer

func enter():
	swing_timer = 0.2
	var atk = entity.item_owner.create_attack()
	var angle = Global.get_gamepad_force("AimPad")
	var area = entity._create_attack_area(atk, entity, angle)

func update(delta):
	swing_timer -= delta
	
	if swing_timer <= 0:
		if owner.is_attacking:
			emit_signal("finished","Cooldown")
		else:
			get_parent().emit_signal("finished", "Idling")

func exit():
	owner.start_cooldown()
	
