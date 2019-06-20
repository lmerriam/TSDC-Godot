extends KinematicBody2D


export var speed = 100

var components = ComponentLibrary.init_components(self,[ComponentInventory,ComponentEquipment,ComponentStats])
var inventory = components[ComponentInventory]
var stats = components[ComponentStats]
var equipment = components[ComponentEquipment]

func _init():
	Global.player = self

func _ready():
	# Start sprite
	$AnimatedSprite.play()
	
	# Set up equipment and inventory
	Global.inventory = inventory # Easier to send to inv from anywhere
	equipment.set_equipped(ItemLibrary.instance_item("axe"))
	
func _process(delta):
	if Input.is_action_pressed("attack"):
		equipment.get_equipped("weapon").attack()

func _physics_process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite.flip_h = false;
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite.flip_h = true;
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.animation = "run"
		
	else:
		$AnimatedSprite.animation = "idle"
	
	move_and_slide(velocity)

func get_inventory_component():
	return inventory

func get_stats_component():
	return stats

func get_equipment_component():
	return equipment