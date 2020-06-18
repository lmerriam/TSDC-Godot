extends Node
class_name EnemySpawnerMob

export(PackedScene) var enemy = preload("res://enemies/Enemy.tscn")
export var count := 1
var remaining = count
