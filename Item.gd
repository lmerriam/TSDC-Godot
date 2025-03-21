extends Node2D
class_name Item

export var type := ""
export var item_name := "Base Item"
export var level := 1 setget set_level
var item_owner

func get_type():
	return type

func set_type(item_type):
	type = item_type

func get_sprite():
	var sprite = $Sprite
	return sprite.texture

func get_name():
	return item_name

func set_level(lvl):
	level = lvl
	$Entity.level = lvl
	$Entity.update_stats()
	return level
