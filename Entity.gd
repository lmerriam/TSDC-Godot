extends Node2D
class_name Entity

# Stats
#export var has_stats := true
export var level := 1
var stats_base := {}
var stats := {}
var stat_modifiers := {}
var stat_increments := {}
signal stats_updated
signal modifiers_updated

# Equipment
export var has_equipment := true
var equipment := {}
var equipment_slots := []
var equipment_stats := {}
var equipment_buffs := []
signal item_equipped
signal item_unequipped
signal item_stats_updated
signal item_buffs_updated

# Inventory
#export var has_inventory := true
var inventory_slots := []
var inventory_control: Control
signal inventory_updated

# Buffs
#export var has_buffs := true
var buffs_base = []
var buffs = []
signal buffs_updated

# Status
#export var has_status := true
var status_current := []

# Health
#export var has_health := true
export var health := 10.0
var max_health = health
signal health_changed
signal killed

# Attacks
#export var has_attacks := true
#export var has_attackable := true
export var faction:String

func _init():
	connect("stats_updated", self, "_on_stats_updated")

###################
#     STATS
###################

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
	# Level stats
	for s in stat_increments:
		if stats.has(s):
			stats[s] = stats[s] + stats[s] * stat_increments[s] * level
	# Equipment
	if has_equipment:
		update_equipment_stats()
		update_equipment_buffs()
		for s in equipment_stats:
			if stats.has(s):
				stats[s] += equipment_stats[s]
			else:
				stats[s] = equipment_stats[s]
	# Let parent know that you were updated son
	emit_signal("stats_updated")
	return stats

func add_modifier(stat,id,value):
	if !stat_modifiers.has(stat):
		stat_modifiers[stat] = {}
	stat_modifiers[stat][id] = value
	emit_signal("modifiers_updated")

func get_modifier_total(stat):
	var value = 1
	if stat_modifiers.has(stat):
		var mods = stat_modifiers[stat]
		for mod in mods:
			value *= mods[mod]
	return value

func remove_modifier(stat, id):
	stat_modifiers[stat].erase(id)
	emit_signal("modifiers_updated")

func _on_stats_updated():
#	if has_health and stats.max_health
	pass

func set_health(_health):
	var _old_health = health
	health = _health
	emit_signal("health_changed", _health, _old_health)
	if health <= 0:
		emit_signal("killed")
	return health

func modify_health(amount):
	return set_health(health + amount)

###################
#    EQUIPMENT
###################

func get_equipment():
	return equipment

func update_equipment_stats():
	equipment_stats.clear()
	for item_type in equipment:
		var item = get_equipped(item_type)
		var item_stats = item.stats
		for s in item_stats:
			if equipment_stats.has(s):
				equipment_stats[s] += item_stats[s]
			else:
				equipment_stats[s] = item_stats[s]
	emit_signal("item_stats_updated")

func update_equipment_buffs():
	equipment_buffs.clear()
	for item_type in equipment:
		var item = get_equipped(item_type)
		equipment_buffs += item.buffs
	emit_signal("item_buffs_updated")

func get_equipment_stats():
	return equipment_stats

func get_equipped(type):
	if equipment.has(type):
		return equipment[type]

func set_equipped(item):
	var type = item.get_type()
	if is_instance_valid(item) and accepts_type(type):
		equipment[type] = item
		update_stats()
		update_buffs()
		
		item.connect("item_stats_updated", self, "_on_item_stats_updated")
		item.connect("item_buffs_updated", self, "_on_item_buffs_updated")
		emit_signal("item_equipped", item)
		
		return true
	return false

func remove_equipped(item):
	var type = item.get_type()
	equipment.erase(type)
	update_stats()
	update_buffs()
	
	# Hook up signals
	emit_signal("item_unequipped", item)
	if item.is_connected("item_stats_updated", self, "_on_item_stats_updated"):
		item.disconnect("item_stats_updated", self, "_on_item_stats_updated")
	if item.is_connected("item_buffs_updated", self, "_on_item_buffs_updated"):
		item.disconnect("item_buffs_updated", self, "_on_item_buffs_updated")

func remove_equipped_type(type):
	var item = get_equipped(type)
	remove_equipped(item)

func set_equipment_slots(slots: Array):
	equipment_slots = slots

func accepts_type(type):
	return true if equipment_slots.has(type) or equipment_slots.empty() else false

func _on_item_stats_updated():
	update_stats()

func _on_item_buffs_updated():
	update_buffs()

###################
#    INVENTORY
###################

func add_item(item):
	inventory_slots.append(item)
	emit_signal("inventory_updated")
	return item

func remove_item(item):
	inventory_slots.erase(item)
	emit_signal("inventory_updated")
	return item

func get_item(slot):
	return inventory_slots[slot]

func set_list_control(new_control):
	if inventory_control and is_connected("inventory_updated", inventory_control, "_on_inventory_updated"):
		disconnect("inventory_updated", inventory_control, "_on_inventory_updated")
	connect("inventory_updated", new_control, "_on_inventory_updated")
	inventory_control = new_control
	new_control.slots = inventory_slots

###################
#  BUFFS & STATUS
###################
func add_status(status):
	status_current.append(status)
#	add_child(status)

func remove_status(status):
	status_current.erase(status)

func get_buffs():
	return buffs

func get_buffs_base():
	return buffs_base

func add_buff(new_buff):
	buffs.append(new_buff)

func add_buff_base(new_buff):
	buffs_base.append(new_buff)
	update_buffs()

func update_buffs():
	buffs = buffs_base.duplicate()
	update_equipment_buffs()
	buffs += equipment_buffs
	emit_signal("buffs_updated")

###################
#    ATTACKS
###################

###################
#    STATE
###################