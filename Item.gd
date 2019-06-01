extends Node2D
class_name Item

var type
var item_name

var stats_component = ComponentStats.new()
var equipment_component = ComponentEquipment.new()

func _init():
	add_child(stats_component,true)
	add_child(equipment_component,true)

func get_stats_component():
	return stats_component

func get_equipment_component():
	return equipment_component

func get_type():
	return type

func set_type(item_type):
	type = item_type

func get_sprite():
	var sprite = get_node("Sprite")
	return sprite.texture

func get_name():
	return item_name

func get_stats():
	return stats_component.get_stats()

func get_stats_base():
	return stats_component.get_stats_base()