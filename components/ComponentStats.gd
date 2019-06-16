extends ComponentBase
class_name ComponentStats

var type = "ComponentStats"
var stats_base = {}
var stats = {}
var stat_modifiers = {}

var equipment

func init(_entity,_siblings):
	.init(_entity,_siblings)
	if entity.has_method("get_equipment_component"):
		equipment = entity.get_equipment_component()

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

func set_stats_base(_stats):
	stats_base = _stats
	update_stats()

func add_to_stat_base(stat_name, value_to_add):
	if stats_base.has(stat_name):
		stats_base[stat_name] += value_to_add
		return stats_base[stat_name]
	else:
		return null

func update_stats():
	stats = stats_base.duplicate()
	if entity.has_method('get_equipment_component'):
		var eqp_stats = entity.get_equipment_component().update_equipment_stats()
		for s in eqp_stats:
			if stats.has(s):
				stats[s] += eqp_stats[s]
			else:
				stats[s] = eqp_stats[s]
	return stats

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