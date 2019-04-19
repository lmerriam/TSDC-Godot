extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var health = 10
export var speed = .8
onready var origin = global_position

enum {HOME, CHASE, IDLE}

var state = HOME
var state_prev

signal killed(id)

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
			else:
				state = IDLE
		CHASE:
			var player_pos = Global.player.global_position
			var velocity = (player_pos - global_position).normalized()
			move_and_slide(velocity * speed)
		IDLE:
			continue

func take_damage(damage):
	health -= damage

func _on_AggroRadius_body_entered(body):
	if body == Global.player:
		self.state = CHASE

func _on_ChaseRadius_body_exited(body):
	if body == Global.player:
		self.state = HOME