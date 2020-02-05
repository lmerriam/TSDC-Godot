extends KinematicBody2D

export var speed = 100
onready var sprite = $AnimatedSprite

var attack_move_speed = 1

signal attack_started
signal attack_ended
signal spell_started
signal spell_ended

func _init():
	Global.player = self


func _ready():
	sprite.play()
	$Entity.set_stat_base("damage", 3)


func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		emit_signal("attack_started")
	elif event.is_action_released("attack"):
		emit_signal("attack_ended")
	
	var skill = $Entity.get_equipped("Skill1")
	if event.is_action_pressed("skill_1"):
		if skill:
			skill.on_cast_started()
	elif event.is_action_released("skill_1"):
		if skill:
			skill.on_cast_ended()


func _physics_process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		sprite.flip_h = false;
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		sprite.flip_h = true;
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		sprite.animation = "run"
	else:
		sprite.animation = "idle"
	
	#TODO: modify player speed when attacking
	move_and_slide(velocity*attack_move_speed)


func receive_attack(atk):
	var dmg = atk.damage
	$Entity.modify_health(-dmg)


func _on_Player_attack_started():
	var weapon = $Entity.get_equipped("Weapon")
	if weapon:
		attack_move_speed = weapon.player_speed_modifier
		weapon.on_attack_started()


func _on_Player_attack_ended():
	attack_move_speed = 1
	var weapon = $Entity.get_equipped("Weapon")
	if weapon:
		weapon.on_attack_ended()


func _on_entity_tree_entered():
	Global.player_entity = $Entity
