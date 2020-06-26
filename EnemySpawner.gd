extends Node2D

export var active := false
export var max_active_spawns := 5
export var spawn_rate := 2

var mobs
var current_mob
var spawn_timer

var locations

var active_spawns : Array

signal mob_defeated
signal all_mobs_defeated

func _ready():
	mobs = $MobList.get_children()
	locations = $LocationList.get_children()
	assert(locations.size() > 0) #Need at least one spawn location
	current_mob = 0
	start()

func spawn_mob(mob):
	for i in mob.count:
		var enemy = mob.enemy.instance()
		active_spawns.append(enemy)
		Global.entities.call_deferred("add_child", enemy)
		enemy.global_position = locations[randi() % locations.size()].global_position
		enemy.connect("killed", self, "_on_enemy_killed")
		enemy.chase_timer = 9999

func _on_enemy_killed(enemy):
	active_spawns.erase(enemy)
	if active_spawns.size() <= 0:
		if current_mob < mobs.size()-1:
			emit_signal("mob_defeated", current_mob)
			current_mob += 1
			spawn_mob(mobs[current_mob])
		else:
			emit_signal("all_mobs_defeated")

func start():
	call_deferred("spawn_mob", mobs[0])

