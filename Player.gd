extends KinematicBody2D

export var speed = 100

var equipment_slots = {
	"weapon": $WeaponSlot,
	"armor": $ArmorSlot
}

func _ready():
	add_to_group("player")
	Global.player = self
	$AnimatedSprite.play()

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
	var slot = equipment_slots[type]
	var old_equipment = get_equipped(type)
	
	slot.remove_child()
	slot.add_child(new_equipment)
	
	old_equipment.queue_free()

func get_equipped(type):
	return get_child(equipment_slots[type])