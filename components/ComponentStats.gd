extends Node

var stats_base = {}
var stats = {speed = 1}
var stat_modifiers = {}

var status_current = []

func _ready():
	pass

func apply_status(status):
	status_current.append(status)
	add_child(status)

func remove_status(status):
	status_current.erase(status)

func get_stat(stat):
	var value = stats[stat]
	var mod = get_modifier_total(stat)
	return value * mod

func add_modifier(stat,id,value):
	if !stat_modifiers.has(stat):
		stat_modifiers[stat] = {}
	stat_modifiers[stat][id] = value

func get_modifier_total(stat):
	var value = 1
	var mods = stat_modifiers[stat]
	for mod in mods:
		value *= mods[mod]
	return value

func remove_modifier(stat, id):
	stat_modifiers[stat].erase(id)

func update_stats():
	stats = stats_base.duplicate()
	for type in equipment:
		var item_stats = get_equipped(type).get_stats()
		for s in item_stats:
			stats[s] += item_stats[s]

func get_stat_base(stat):
	if stats_base.has(stat):
		return stats_base[stat]

func get_stat_final(stat):
	if stats.has(stat):
		return stats[stat]