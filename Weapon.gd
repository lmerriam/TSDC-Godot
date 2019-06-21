extends Item
class_name Weapon

var attack_area: Resource
var cooldown := 0.0
var player_speed_modifier := .5

func _init():
	set_type("weapon")

func _process(delta):
	cooldown -= delta

func _create_attack_area(resource, parent, angle = null, origin = null):
	
	# Instance the attack area
	var area = attack_area.instance()
	area.set_attack_resource(resource)
	
	# Parent the attack
	parent.add_child(area)
	
	# Put the attack in the right spot relative to it's parent
	if origin:
		area.set_position(origin)
	
	# Point the attack in the right direction
	if angle:
		area.set_angle(angle)
	
	return area

func set_cooldown(atk_speed):
	cooldown = 1.0 / atk_speed

func on_cooldown():
	return true if cooldown >= 0 else false

func _get_vector_to_mouse():
	var mouse_pos = get_global_mouse_position()
	var vec = (mouse_pos - global_position).normalized()
	return vec