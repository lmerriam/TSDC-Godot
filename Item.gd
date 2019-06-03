extends Node2D
class_name Item

var type
var item_name

var components = ComponentLibrary.init_components(self,[ComponentStats,ComponentEquipment])
var stats_component = get_component(ComponentStats)
var equipment_component = get_component(ComponentEquipment)

func get_component(type):
	return components[type]

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
	return get_stats_component().get_stats()

func get_stats_base():
	return get_stats_component().get_stats_base()