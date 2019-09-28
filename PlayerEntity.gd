extends Entity
class_name Player

export var speed = 100
var attacking
onready var sprite = $Player/AnimatedSprite

signal attack_started
signal attack_ended

func _init():
	Global.player = self
	set_equipment_slots(["weapon", "armor", "footwear", "amulet"])

func _ready():
	Global.player_character = $Player
	sprite.play()
	set_equipped(ItemLibrary.instance_item("swordnew"))

func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		emit_signal("attack_started")
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
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		sprite.animation = "run"
	else:
		sprite.animation = "idle"
	
	if attacking:
		velocity *= .5
	
	$Player.move_and_slide(velocity)

func receive_attack(atk):
	var dmg = atk.damage
	set_health(health - dmg)

func set_equipped(item):
#	Events.publish("player equipped item", item)
	.set_equipped(item)
	if item.get_parent():
		item.get_parent().remove_child(item)
	if item.get_type() == "weapon":
		connect("attack_started", item, "on_attack_started")
		connect("attack_ended", item, "on_attack_ended")
	$Player/WeaponOrigin.add_child(item)
	item.position = Vector2(0,0)

func remove_equipped(item):
#	Events.publish("player unequipped item", item)
	.remove_equipped(item)
	item.get_parent().remove_child(item)
	if item.get_type() == "weapon":
		disconnect("attack_started", item, "on_attack_started")
		disconnect("attack_ended", item, "on_attack_ended")
	Global.entities.add_child(item)
	item.position = Vector2(-999,-999)