extends Node
class_name EnemySpawnerMob

export(PackedScene) var enemy = preload("res://enemies/Enemy.tscn")
export var count := 1

export var spawn_delay := 0.0
export var max_spawns := 999

var remaining = count

func instance_spawn():
	return enemy.instance()
