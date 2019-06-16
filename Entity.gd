extends Node

# Stats
var stats_base = {}
var stats = {}
var stat_modifiers = {}

# Equipment
var equipment := {}
var equipment_slots := []
var equipment_stats_cumulative := {}

# Inventory

# Status/Buffs

# Attacks

###################
#     STATS
###################

func _ready():
	pass

func get_stats():
	return stats

func set_stats(_stats):
	stats = _stats

func get_stats_base():
	return stats_base

func get_stat(stat):
	if stats.has(stat):
		var value = stats[stat]
		var mod = get_modifier_total(stat)
		return value * mod

func get_stat_base(stat):
	if stats_base.has(stat):
		return stats_base[stat]

func set_stat_base(stat_name, value):
	stats_base[stat_name] = value
	update_stats()

func add_to_stat_base(stat_name, value_to_add):
	if stats_base.has(stat_name):
		stats_base[stat_name] += value_to_add
		return stats_base[stat_name]
	else:
		return null

func update_stats():
	stats = stats_base.duplicate()
	update_stats_with_equipment()

func add_modifier(stat,id,value):
	if !stat_modifiers.has(stat):
		stat_modifiers[stat] = {}
	stat_modifiers[stat][id] = value

func get_modifier_total(stat):
	var value = 1
	if stat_modifiers.has(stat):
		var mods = stat_modifiers[stat]
		for mod in mods:
			value *= mods[mod]
	return value

func remove_modifier(stat, id):
	stat_modifiers[stat].erase(id)

###################
#    EQUIPMENT
###################

func update_stats_with_equipment():
	var stats = get_stats_base().duplicate()
	for item in equipment:
		var item_stats = get_equipped(item).get_stats()
		for s in item_stats:
			if stats.has(s):
				stats[s] += item_stats[s]
			else:
				stats[s] = item_stats[s]
		if buffs:
			entity.buffs += get_equipped(item).buffs

func get_equipped(type):
	return equipment[type]

func set_equipped(item):
	var type = item.get_type()
	if is_instance_valid(item) and accepts_type(type):
		equipment[type] = item
#		item.get_equipment_component().update_stats_with_equipment()
		update_stats_with_equipment()
		
		# Reparent thi bih
		if not item.get_parent():
			entity.add_child(item)
		
		return true
	return false

func remove_equipped(item):
	var type = item.get_type()
	equipment[type] = null
	entity.remove_child(item)
#	item.visible = false

func remove_equipped_type(type):
	var item = get_equipped(type)
	remove_equipped(item)

func set_equipment_slots(slots: Array):
	equipment_slots = slots

func accepts_type(type):
	return true if equipment_slots.has(type) or equipment_slots.empty() else false