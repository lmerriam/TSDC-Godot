extends State

var current_charge
export(Texture) var charging_sprite


func enter():
	current_charge = 0
	entity.get_node("Sprite").texture = charging_sprite


func update(delta):
	if entity.is_attacking == false:
		var atk = entity.item_owner.create_attack()
		var angle = entity._get_vector_to_mouse()
		var area = entity._create_attack_area(atk, Global.entities, angle, entity.global_position)
		atk.damage *= get_damage_multiple()
		area.speed *= clamp(get_damage_multiple(), .5, 1)
		emit_signal("finished","cooldown")
		
	current_charge += delta
	var rot = Global.player.global_position.angle_to_point(entity.get_global_mouse_position())
	entity.get_node("Sprite").rotation = rot + .75


func exit():
	entity.start_cooldown()


func get_damage_multiple():
	var pct = clamp(current_charge / entity.charge_time + .5, 0, 1)
	return pct