extends KinematicBody2D

export var speed = 100

var stats_base = {}
var stats_final = {}

onready var equipment_slots = {
	"weapon": $WeaponSlot,
	"armor": $ArmorSlot
}

func _ready():
	Global.player = self
	$AnimatedSprite.play()
	set_equipped(Items.instance_item("sword"))

func _physics_process(delta):
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		$AnimatedSprite.flip_h = false;
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		$AnimatedSprite.flip_h = true;
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.animation = "run"
		
	else:
		$AnimatedSprite.animation = "idle"
	
	move_and_slide(velocity)

func set_equipped(new_equipment):
	var type = new_equipment.get_type()
	var slot = get_equipment_slot(type)
	var old_equipment = get_equipped(type)
	
	slot.remove_child(old_equipment)
	slot.add_child(new_equipment)
	
	old_equipment.queue_free()

func get_equipped(type):
	var slot = get_equipment_slot(type)
	return slot.get_children()[0]

func get_equipment_slot(type):
	return equipment_slots.get(type)

func update_stats():
	pass

func get_stat_base(stat):
	if stats_base.has(stat):
		return stats_base[stat]

func get_stat_final(stat):
	if stats_final.has(stat):
		return stats_final[stat]