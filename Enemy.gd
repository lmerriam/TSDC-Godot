extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var health = 10
export var speed = .8
onready var origin = global_position

enum {HOME, CHASE}

var spawner = false
var state = HOME

signal killed(id)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Die if no health
	if health <= 0:
		emit_signal("killed",self)
		queue_free()
	
	match state:
		HOME:
			if global_position.distance_to(origin) > 4:
				var velocity = (origin - global_position).normalized()
				move_and_slide(velocity * speed)
		CHASE:
			var player_pos = GameState.player.global_position
			var velocity = (player_pos - global_position).normalized()
			move_and_slide(velocity * speed)

func take_damage(damage):
	health -= damage

func _on_AggroRadius_body_entered(body):
	if body == GameState.player:
		state = CHASE

func _on_ChaseRadius_body_exited(body):
	if body == GameState.player:
		state = HOME
