extends StaticBody2D

export var aggro_radius = 128
var defeated = false
var spawned = false
var enemy = preload("res://Enemy.tscn")
var enemies_spawned = []

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass

func _on_SpawnKilled(id):
	
	# Remove spawn from list of spawns
	enemies_spawned.erase(id)
	
	# If all spawns have been destroyed, stronghold is complete
	if enemies_spawned.size() <= 0:
		defeated = true
		print("Stronghold defeated")

func _on_AggroRadius_body_entered(body):
	
	# Spawn the 
	if !spawned and body == GameState.player:
		for i in 8:
			var spawn = enemy.instance()
			enemies_spawned.append(spawn)
			var offset = Vector2(rand_range(-50,50),rand_range(-50,50))
			spawn.global_position = global_position + offset
			GameState.entities.add_child(spawn)
			spawn.connect("killed",self,"_on_SpawnKilled")
		spawned = true
