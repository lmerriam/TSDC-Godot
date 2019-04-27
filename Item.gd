extends Node2D
class_name Item

var type

var stats_base = {}
var stats = {}
var buffs = {}
var components = {}

#func _ready():
#	pass

func get_type():
	return type

func set_type(item_type):
	type = item_type

func get_stats():
	return stats

func get_stat(stat):
	if stats.has(stat):
		return stats[stat]

func get_stat_base(stat):
	if stats.has(stat):
		return stats_base[stat]

func update_stats():
	stats = stats_base.duplicate()
	for comp in components:
		var comp_stats = get_component(comp).get_stats()
		for s in comp_stats:
			stats[s] += comp_stats[s]

func set_stat_base(stat, value):
	stats_base[stat] = value
	update_stats()

func get_buffs():
	return buffs

func get_buff(buff):
	return buffs[buff]

func set_buff(buff, values):
	buffs[buff] = values

func get_component(type):
	return components[type]

func set_component(instance):
	if is_instance_valid(instance):
		var type = instance.get_type()
		components[type] = instance
		add_child(instance)
		update_stats()
		return true
	return false

func remove_component(type):
	var instance = get_component(type)
	components.erase(type)
	remove_child(instance)