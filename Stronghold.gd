extends StaticBody2D

export var aggro_radius = 128
var defeated = false
var spawned = false
var enemy = preload("res://Enemy.tscn")
var enemies_spawned = []

func _ready():
	var tilemap = get_parent()
	var tile = tilemap.tile_set.find_tile_by_name("rock")
	Generators.gen_building(global_position / 16, 13, 13, tilemap, tile)

func _on_SpawnKilled(id):
	
	# Remove spawn from list of spawns
	enemies_spawned.erase(id)
	
	# If all spawns have been destroyed, stronghold is complete
	if enemies_spawned.size() <= 0:
		defeated = true
		print("Stronghold defeated")

func _on_AggroRadius_body_entered(body):
	
	# Spawn the 
	if !spawned and body == Global.player:
		for i in 8:
			call_deferred("_spawn_enemy")
		spawned = true

func _spawn_enemy():
	var spawn = enemy.instance()
	enemies_spawned.append(spawn)
	spawn.mob = enemies_spawned
	var offset = Vector2(rand_range(-50,50),rand_range(-50,50))
	spawn.global_position = global_position + offset
	Global.entities.add_child(spawn)
	spawn.connect("killed",self,"_on_SpawnKilled")