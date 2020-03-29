extends Equipment
class_name Weapon

export var player_speed_modifier := .5
export var damage := 0.0
export var attack_speed := 1
export var knockback := 0.0
export var stagger := 0.0
export var charge_time := 0.0
export var angle_vary := 0.0
export var attack_area = preload("res://attacks/Slash.tscn")

var is_attacking = false
var active_attack_areas = []

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


func on_attack_started():
	is_attacking = true


func on_attack_ended():
	is_attacking = false

func remove_active_attack(attack):
	active_attack_areas.erase(attack)

func add_active_attack(attack):
	active_attack_areas.append(attack)
