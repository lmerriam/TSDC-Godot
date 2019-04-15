extends KinematicBody2D

export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player")
	GameState.player_id = self
	$AnimatedSprite.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
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