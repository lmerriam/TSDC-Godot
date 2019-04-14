extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var health = 10
export var speed = .8

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Die if no health
	if health <= 0:
		queue_free()
	
	# Move toward player
	var player = get_tree().get_nodes_in_group("player")[0]
	if player != null:
		var player_pos = player.global_position
		var velocity = (player_pos - global_position).normalized()
		move_and_collide(velocity * speed)

func take_damage(damage):
	health -= damage