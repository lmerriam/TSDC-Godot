extends Entity
class_name Player

export var speed = 100
var attacking
onready var sprite = $Player/AnimatedSprite

func _init():
	Global.player = self
	set_equipment_slots(["weapon", "armor"])

func _ready():
	Global.player_character = $Player
	sprite.play()
	set_equipped(ItemLibrary.instance_item("bow"))
	
func _process(delta):
	attacking = false
	
	if Input.is_action_pressed("attack"):
		get_equipped("weapon").attack()
		attacking = true

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
	
	if attacking: # Slow the player when attacking
		velocity *= .5
	
	$Player.move_and_slide(velocity)

func set_equipped(item):
	.set_equipped(item)
	$Player.add_child(item)

func remove_equipped(item):
	.remove_equipped(item)
	$Player.remove_child(item)