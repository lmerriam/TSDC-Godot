extends StaticBody2D

export var aggro_radius = 128
export var level = 1 setget set_level
var defeated = false
var spawned = false
var enemy = preload("res://enemies/Enemy.tscn")
var enemies_spawned = []

func _on_SpawnKilled(id):
	
	# Remove spawn from list of spawns
	enemies_spawned.erase(id)
	
	# If all spawns have been destroyed, stronghold is complete
	if enemies_spawned.size() <= 0:
		defeated = true
		print("Stronghold defeated")
		for item in range(0,3):
			var i = ItemLibrary.instance_random_loot()
			i.get_item().level = level
			i.global_position = global_position + Vector2(rand_range(-64,64), rand_range(-64,64))

func _on_AggroRadius_body_entered(body):
	# Spawn the enemies
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

func set_level(lvl):
	level = lvl
	$Label.text = String(level)
	return level
