extends Node
class_name ComponentEquippable

var equipment = {}
var parent = get_parent()
var stats = parent.get_stats()
var stats_base = parent.get_stats_base()

func update_stats():
	stats = stats_base.duplicate()
	for comp in equipment:
		var comp_stats = get_equipped(comp).get_stats()
		for s in comp_stats:
			stats[s] += comp_stats[s]

func get_equipped(type):
	return equipment[type]

func set_equipped(equipment):
	if is_instance_valid(equipment):
		var type = equipment.get_type()
		equipment[type] = equipment
		add_child(equipment)
		update_stats()
		return true
	return false

func remove_equipped(type):
	var instance = get_equipped(type)
	equipment.erase(type)
	remove_child(instance)