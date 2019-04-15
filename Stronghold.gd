extends StaticBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var aggro_radius = 128
var defeated = false
var spawned = false
var enemy = preload("res://Enemy.tscn")
var enemies_spawned = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = GameState.player_id
	if player:
		var dis_to_player = global_position.distance_to(player.global_position)
	
		if !spawned and dis_to_player < aggro_radius:
			for i in 8:
				var inst = enemy.instance()
				enemies_spawned.append(inst)
				var offset = Vector2(rand_range(-50,50),rand_range(-50,50))
				inst.global_position = global_position + offset
				get_node("/root/Game/World/Entities").add_child(inst)
			spawned = true