extends Equipment
class_name Weapon

export var damage := 0.0
export var attack_speed := 1.0
export var knockback := 0.0
export var stagger := 0.0
export var charge_time := 0.0
export var angle_vary := 0.0
export var attack_area = preload("res://attacks/Slash.tscn")

var owner_is_attacking = false
var weapon_is_attacking = false
var active_attack_areas = []

var aim_force := Vector2(0,0)

export var move_speed_modifier := .5
signal move_speed_modifier_updated(new_modifier)


func _init():
	$Entity.stat_increments.damage = .1


func _ready():
	$Entity.set_stat_base("damage", damage)
	$Entity.set_stat_base("attack_speed", attack_speed)
	$Entity.set_stat_base("knockback", knockback)
	$Entity.set_stat_base("stagger", stagger)


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
		var vary = rand_range(-angle_vary, angle_vary)
		area.set_angle(angle.rotated(vary))
	
	return area


func start_cooldown():
	set_cooldown(attack_speed)


func _on_owner_attack_started():
	owner_is_attacking = true


func _on_owner_attack_ended():
	owner_is_attacking = false


func remove_active_attack(attack):
	active_attack_areas.erase(attack)


func add_active_attack(attack):
	active_attack_areas.append(attack)


func _on_item_owner_aim_force_updated(force):
	if force:
		aim_force = force
