extends KinematicBody2D

export var speed = 100
onready var sprite = $AnimatedSprite
const START_WEAPON = preload("res://items/weapon/Sword.tscn")

var attack_move_speed = 1

signal attack_started(entity_id)
signal attack_ended()

func _init():
	Global.player = self


func _ready():
	sprite.play()
	set_equipped(START_WEAPON.instance())


func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		emit_signal("attack_started", $Entity)
	elif event.is_action_released("attack"):
		emit_signal("attack_ended")


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
	
	if Input.is_mouse_button_pressed(BUTTON_RIGHT):
		var scene = load("res://AreaSpell.tscn")
		var spell = scene.instance()
		Global.entities.add_child(spell)
		spell.global_position = get_global_mouse_position()
	
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


func set_equipped(item):
	$Entity.set_equipped(item)
	if item.get_parent():
		item.get_parent().remove_child(item)
	if item.has_method("connect_entity"):
		item.connect_entity(self)
	$WeaponOrigin.add_child(item)
	item.position = Vector2(0,0)


func remove_equipped(item):
	$Entity.remove_equipped(item)
	item.get_parent().remove_child(item)
	if item.has_method("disconnect_entity"):
		item.disconnect_entity(self)
	Global.entities.add_child(item)
	item.position = Vector2(-999,-999)


func _on_Player_attack_started(entity_id):
	var weapon = $Entity.get_equipped("weapon")
	if weapon:
		attack_move_speed = weapon.player_speed_modifier


func _on_Player_attack_ended():
	attack_move_speed = 1
