extends Node2D
class_name Item

var type
var item_name

var stats_base = {}
var stats = {}
var buffs = {}
var components = {
	base = null,
	gem = null,
	inscription = null
}

func get_type():
	return type

func get_sprite():
	var sprite = get_node("Sprite")
	return sprite.texture

func get_name():
	return item_name

func can_equip_type(item_type):
	return components.has(item_type)

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
	# @REFACTOR probably, too much nesting
	stats = stats_base.duplicate()
	for slot in components:
		var comp = get_component(slot)
		if comp:
			var comp_stats = comp.get_stats()
			for s in comp_stats:
				if !stats.get(s): stats[s] = 0
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

func get_components():
	return components

func get_component(slot):
	return components[slot]

func set_component(instance):
	var type = instance.get_type()
	if is_instance_valid(instance) and can_equip_type(type):
		
		# Remove previous
		var prev_component = components[type]
		
		# Attach new
		components[type] = instance
		add_child(instance)
		update_stats()
		
		if prev_component:
			remove_child(prev_component)
			prev_component.queue_free()
		
		return instance

func remove_component(type):
	var instance = get_component(type)
	components.erase(type)
	remove_child(instance)