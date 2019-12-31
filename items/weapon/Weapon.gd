extends Equipment
class_name Weapon

var cooldown := 0.0
var is_attacking = false

export var player_speed_modifier := .5
export var damage := 0.0
export var attack_speed := 1
export var knockback := 0.0
export var stagger := 0.0
export var charge_time := 0.0

export var attack_area = preload("res://attacks/Slash.tscn")

func _init():
	$Entity.stat_increments.damage = .1


func _ready():
	$Entity.set_stat_base("damage", damage)
	$Entity.set_stat_base("attack_speed", attack_speed)
	$Entity.set_stat_base("knockback", knockback)
	$Entity.set_stat_base("stagger", stagger)


func _process(delta):
	cooldown -= delta


func _create_attack_area(props, parent, angle = null, origin = null):
	
	# Instance the attack area
	var area = attack_area.instance()
	area.set_attack_properties(props)
	
	# Parent the attack
	parent.add_child(area)
	
	# Put the attack in the right spot relative to its parent
	if origin:
		area.set_position(origin)
	
	# Point the attack in the right direction
	if angle:
		area.set_angle(angle)
	
	return area


func set_cooldown(atk_speed):
	cooldown = 1.0 / atk_speed


func start_cooldown():
	set_cooldown(attack_speed)


func on_cooldown():
	return true if cooldown >= 0 else false


func _get_vector_to_mouse():
	var mouse_pos = get_global_mouse_position()
	var vec = (mouse_pos - global_position).normalized()
	return vec


func on_attack_started():
	is_attacking = true


func on_attack_ended():
	is_attacking = false
	
