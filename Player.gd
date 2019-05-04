extends KinematicBody2D

export var speed = 100

var stats_base = {}
var stats = {}
var equipment = {
	weapon = null,
	armor = null,
	helmet = null,
	boots = null,
	scroll = null
}

#onready var equipment_slots = {
#	"weapon": $WeaponSlot,
#	"armor": $ArmorSlot
#}

# Components
var inventory = preload("res://components/ComponentInventory.gd").new()

func _init():
	Global.player = self
	Global.inventory = inventory

func _ready():
	add_child(inventory)
	$AnimatedSprite.play()
	var staff = set_equipped(ItemLibrary.instance_item("staff"))
#	staff.set_component(ItemLibrary.instance_item("gemfire"))

func _process(delta):
	if Input.is_action_pressed("attack"):
		get_equipped("weapon").attack()

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

func set_equipped(new_equipment, send_prev_to_inv = true):
	var type = new_equipment.get_type()
	var prev_equipment = get_equipped(type)
	if send_prev_to_inv and prev_equipment:
		Global.inventory.add_item(prev_equipment)
		$WeaponOrigin.remove_child(prev_equipment)
	$WeaponOrigin.add_child(new_equipment)
	equipment[type] = new_equipment
	return new_equipment

func get_equipped(item_type):
	return equipment[item_type]

func update_stats():
	stats = stats_base.duplicate()
	for type in equipment:
		var item_stats = get_equipped(type).get_stats()
		for s in item_stats:
			stats[s] += item_stats[s]

func get_stat_base(stat):
	if stats_base.has(stat):
		return stats_base[stat]

func get_stat_final(stat):
	if stats.has(stat):
		return stats[stat]