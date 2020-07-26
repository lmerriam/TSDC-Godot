extends Node2D

export var active := false
export var max_active_spawns := 5
export var spawn_rate := 1.0

onready var mobs = $SpawnerMobList.get_children()
var current_mob = 0
var current_spawn = 0
var active_spawns : Array
var spawned_count : int
var spawn_timer

onready var locations = $SpawnerLocationList.get_children()
onready var timer := $SpawnTimer

signal mob_defeated
signal all_mobs_defeated
signal all_enemies_spawned

func _ready():
	assert(locations.size() > 0) # Need at least one spawn location
	start()

func spawn_mob(mob):
	for i in mob.count:
		var enemy = mob.enemy.instance()

func spawn_next():
	if mobs.size() > current_mob:
		var mob: EnemySpawnerMob = mobs[current_mob]
		var spawn = mob.instance_spawn()
		active_spawns.append(spawn)
		Global.entities.call_deferred("add_child", spawn)
		spawn.global_position = locations[randi() % locations.size()].global_position
		spawn.connect("killed", self, "_on_enemy_killed")
		spawn.chase_timer = 9999 #TODO: this could be better
		current_spawn += 1
		spawned_count += 1
		$SpawnTimer.start(spawn_rate)
		if current_spawn >= mob.count:
			current_spawn = 0
			if current_mob <= mobs.size() - 1:
				current_mob += 1
			else:
				emit_signal("all_enemies_spawned")

func start():
	current_mob = 0
	current_spawn = 0
	call_deferred("spawn_next")

func attempt_to_spawn():
	if $SpawnTimer.time_left <= 0 and active_spawns.size() < max_active_spawns:
		spawn_next()

func _on_enemy_killed(enemy):
	active_spawns.erase(enemy)
	if active_spawns.size() <= 0:
		if current_mob >= mobs.size()-1:
			emit_signal("all_mobs_defeated")
	attempt_to_spawn()

func _on_timer_up():
	attempt_to_spawn()
