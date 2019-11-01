extends RigidBody2D

var velocity = Vector2(0,0)

export var blood_particles:PackedScene

export var attack_radius := 32
export var chase_radius := 256
export var aggro_radius := 128
var origin_radius = 16
var in_origin_range = false
var in_aggro_range = false
var in_attack_range = false
var in_chase_range = false
var player_dis
var origin_dis

var stun_timer = 0

onready var origin = global_position

var mob: Array
var cooldown = 0
var hitshader = preload("res://all_white_shader.tres")

signal killed(id)

func _ready():
	$Entity.set_stat_base("speed", 1)

func _process(delta):
	
	# Check distances
	var player_pos = Global.player.global_position
	player_dis = global_position.distance_to(player_pos)
	origin_dis = global_position.distance_to(origin)
	
	in_aggro_range = false
	in_attack_range = false
	in_chase_range = false
	in_origin_range = false
	
	if player_dis < aggro_radius:
		in_aggro_range = true
	
	if player_dis < chase_radius:
		in_chase_range = true
	
	if player_dis < attack_radius:
		in_attack_range = true
	
	if origin_dis < origin_radius:
		in_origin_range = true


func _on_attack_received(atk):
	
	if atk.has("knockback"):
		var angle = Global.player.global_position.angle_to_point(global_position)
		var kb = -Vector2(cos(angle), sin(angle)) * atk.knockback
		knockback(kb)
	
	if atk.has("stagger"):
		$StateMachine._change_state("stunned")
		stun_timer = atk.stagger
	
	if atk.has("bleed"):
		var angle = Global.player.global_position.angle_to_point(global_position)
		bleed(angle)
	
	$DamageAnimation.play("DamageFlashWhite")


func move_toward_point(vec):
	velocity = (vec - global_position).normalized() * $Entity.get_stat("speed")


func add_status(status):
	$Entity.add_status(status)
	add_child(status)


func _on_Hitbox_area_entered(area):
	if area is AttackArea and $Entity.receive_attack(area.properties):
		area.attack_successful(self)


func knockback(vector):
	apply_central_impulse(vector)


func _integrate_forces(state):
	var t = state.get_transform()
	t.origin.x += velocity.x
	t.origin.y += velocity.y
	state.set_transform(t)
	
	velocity = Vector2(0,0)


func bleed(angle):
	var blood = blood_particles.instance()
	Global.entities.add_child(blood)
	blood.global_rotation = angle-3.1416
	blood.global_position = global_position
	return blood


func _on_Entity_killed():
	var angle = Global.player.global_position.angle_to_point(global_position)
	bleed(angle)
	bleed(angle-.2)
	bleed(angle+.2)
	emit_signal("killed",self)
	call_deferred("queue_free")
