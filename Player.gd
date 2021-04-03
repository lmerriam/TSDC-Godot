extends KinematicBody2D

export var speed = 100
onready var sprite = $AnimatedSprite

var attack_move_speed = 1
var move_force = Vector2(0,0)
var aim_force = Vector2(0,0)

signal attack_started
signal attack_ended
signal spell_started
signal spell_ended

signal aim_force_updated
signal move_force_updated

func _init():
	Global.player = self


func _ready():
	sprite.play()
	$Entity.set_stat_base("damage", 3)
	$Entity.set_stat_base("speed", 100)
	for type in ItemLibrary.equipment:
		for item in ItemLibrary.equipment[type]:
			$Entity.add_item(ItemLibrary.instance_item(item))


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
	
	if event.device != -1 and event is InputEventMouseMotion:
		aim_force = get_global_mouse_position() - global_position
		emit_signal("aim_force_updated",aim_force)


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
		velocity = velocity.normalized() * $Entity.stats.speed
		sprite.animation = "run"
	else:
		sprite.animation = "idle"
	
	if move_force:
		velocity = move_force * $Entity.stats.speed
	
	move_and_slide(velocity*attack_move_speed)


func receive_attack(atk):
	var dmg = atk.damage
	$Entity.modify_health(-dmg)


func _on_entity_tree_entered():
	Global.player_entity = $Entity


func _on_MovePad_force_changed(padname, force):
	move_force = force
	emit_signal("move_force_updated", force)


func _on_AimPad_force_changed(padname, force):
	aim_force = force
	emit_signal("aim_force_updated", force)


func _on_Entity_item_equipped(item):
	if item is Weapon:
		connect("aim_force_updated", item, "_on_item_owner_aim_force_updated")
		item.connect("move_speed_modifier_updated", self, "_on_move_speed_modifier_updated")


func _on_Entity_item_unequipped(item):
	if item is Weapon:
		attack_move_speed = 1
		if is_connected("aim_force_updated",item,"_on_item_owner_aim_force_updated"):
			disconnect("aim_force_updated",item,"_on_item_owner_aim_force_updated")
		if item.is_connected("move_speed_modifier_updated", self, "_on_move_speed_modifier_updated"):
			item.disconnect("move_speed_modifier_updated", self, "_on_move_speed_modifier_updated")


func _on_Player_attack_started():
	var weapon = $Entity.get_equipped("Weapon")
	if weapon:
		weapon._on_owner_attack_started()


func _on_Player_attack_ended():
	var weapon = $Entity.get_equipped("Weapon")
	if weapon:
		weapon._on_owner_attack_ended()


func _on_move_speed_modifier_updated(modifier):
	attack_move_speed = modifier


func _on_state_change_requested(state_name, props):
	$StateMachine.transition_to(state_name)

func _on_Hitbox_area_entered(area):
	if area is AttackArea and $Entity.receive_attack(area.properties):
		area.attack_successful(self)
