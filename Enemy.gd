extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var health = 10
export var speed = .8
export var aggro_radius = 128
onready var origin = global_position
var spawner = false

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
	
	# Move toward player
	var player = GameState.player
	if player:
		var dis_to_player = global_position.distance_to(player.global_position)
		if dis_to_player < aggro_radius:
			var player_pos = player.global_position
			var velocity = (player_pos - global_position).normalized()
			move_and_slide(velocity * speed)
		else:
			var velocity = (origin - global_position).normalized()
			move_and_slide(velocity * speed)

func take_damage(damage):
	health -= damage