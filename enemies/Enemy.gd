extends RigidBody2D

var velocity = Vector2(0,0)

export var blood_particles:PackedScene

export var move_speed := 1.0
export var attack_radius := 32
export var chase_radius := 256
export var aggro_radius := 128
var origin_radius = 16
var in_origin_range = false
var in_aggro_range = false
var in_attack_range = false
var in_chase_range = false
var target_dis = 999
var origin_dis = 0

export var attack_speed = 1
var attack_timer = 0
var stun_timer = 0
var chase_timer = 0

var target

onready var origin = global_position

var mob: Array
var cooldown = 0
var hitshader = preload("res://all_white_shader.tres")

signal killed(id)
signal animation_finished(anim)

func _ready():
	$Entity.set_stat_base("speed", move_speed)
	$Entity.set_stat_base("damage", 1)
	$Entity.set_stat_base("knockback", 100)
	
	$Healthbar.max_value = $Entity.health
	$Healthbar.value = $Entity.health
	

func _physics_process(delta):
	
	# Check distances
	target = Global.player
	if target != null:
		var target_pos = target.global_position
		target_dis = global_position.distance_to(target_pos)
		origin_dis = global_position.distance_to(origin)
	
	in_aggro_range = false
	in_attack_range = false
	in_chase_range = false
	in_origin_range = false
	
	if target_dis < aggro_radius:
		in_aggro_range = true
	
	if target_dis < chase_radius:
		in_chase_range = true
	
	if target_dis < attack_radius:
		in_attack_range = true
	
	if origin_dis < origin_radius:
		in_origin_range = true
	
#	stun_timer -= delta
	attack_timer -= delta
	chase_timer -= delta


func _on_attack_received(atk):
#	TODO: make knockback and blood effects dependent on attack area position
	if atk.has("knockback"):
		var angle = Global.player.global_position.angle_to_point(global_position)
		var kb = -Vector2(cos(angle), sin(angle)) * atk.knockback
		knockback(kb)
	
	if atk.has("stagger"):
		$StateMachine._change_state("Stunned")
		stun_timer = atk.stagger
	
	if atk.has("bleed"):
		var angle = Global.player.global_position.angle_to_point(global_position)
		bleed(angle)
	
	Global.camera.add_stress(.2)
	
	chase_timer = 3
	
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


func set_state(state_name):
	$StateMachine.get_parent()._change_state(state_name)

func play_animation(anim_name):
	$AnimationPlayer.play(anim_name)

func get_current_animation():
	return $AnimationPlayer.get_animation()


func _on_Entity_killed():
	var angle = Global.player.global_position.angle_to_point(global_position)
	bleed(angle)
	bleed(angle-.2)
	bleed(angle+.2)
	emit_signal("killed",self)
	call_deferred("queue_free")


func _on_animation_finished(anim):
	emit_signal("animation_finished", anim)


func _on_Entity_health_changed(health, old_health):
	if health < $Entity.stats["health"]:
		$Healthbar.visible = true
		$Healthbar.value = health
