extends State

var area

func enter():
	var atk = entity.item_owner.create_attack()
	atk.damage /= 4
	var angle = owner.aim_force
	area = entity._create_attack_area(atk, Global.player, angle)
	area.global_position = entity.global_position

func update(delta):
	if not entity.is_attacking:
		emit_signal("finished","Idling")
	
	area.set_angle(owner.aim_force)

func exit():
	area.queue_free()
