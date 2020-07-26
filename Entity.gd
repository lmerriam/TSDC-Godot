extends Node2D
class_name Entity

# Stats
#export var has_stats := true
export var level := 1
var stats_base := {}
var stats := {}
var stat_modifiers := {}
export var stat_increments := {}
signal stats_updated
signal modifiers_updated

# Equipment
export var has_equipment := true
var equipment := []
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
signal killed(id)

# Attacks
export var faction:String
var dmg_counter = preload("res://Damage Counter.tscn")
signal attack_received(atk)

func _init():
	connect("stats_updated", self, "_on_stats_updated")

#func _exit_tree():
#	for item in equipment:
#		item.queue_free()

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

# TODO: Update only necessary stats instead of all of them
#func update_stat(stat, value):
#	stats[stat] = stats_base[stat]
#	if stats.has(stat):
#		stats[stat] += stats[stat] * stat_increments[stat] * level
#	if has_equipment:
#		for s in equipment_stats:
#			if stats.has(s):
#				stats[s] += equipment_stats[s]
#			else:
#				stats[s] = equipment_stats[s]
#	emit_signal("stats_updated")
#	return stats

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

func update_equipment_stats():
	equipment_stats.clear()
	for item in equipment:
		var item_stats = item.get_node("Entity").stats
		for s in item_stats:
			if equipment_stats.has(s):
				equipment_stats[s] += item_stats[s]
			else:
				equipment_stats[s] = item_stats[s]
	emit_signal("item_stats_updated")

func update_equipment_buffs():
	equipment_buffs.clear()
	for item in equipment:
		var item_buffs = item.get_node("Entity").buffs
		equipment_buffs += item_buffs
	emit_signal("item_buffs_updated")

func get_equipped(slot):
	if $Equipment.get_node(slot).get_child_count() > 0:
		return $Equipment.get_node(slot).get_child(0)
	return false

func set_equipped(item, slot):
	if get_equipped(slot):
		remove_equipped(slot, false)
		
	if item.get_parent():
		item.get_parent().remove_child(item)
	
	$Equipment.get_node(slot).add_child(item)
	item.position = Vector2(0,0)
	item.get_node("Entity").faction = faction
	item.item_owner = self
	connect_equipment(item)
	update_equipment()
	emit_signal("item_equipped", item)

func remove_equipped(slot, update_required=true):
	var item = get_equipped(slot)
	$Equipment.get_node(slot).remove_child(item)
	Global.entities.add_child(item)
	
	if update_required:
		update_equipment()
	
	emit_signal("item_unequipped", item)
	disconnect_equipment(item)

func update_equipment():
	equipment.clear()
	equipment_slots.clear()
	for slot in $Equipment.get_children():
		equipment_slots.append(slot.name)
		if slot.get_child_count() > 0:
			equipment.append(slot.get_child(0))
	update_stats()
	update_buffs()

func accepts_type(type):
	return true if find_equipment_slot(type) else false

func get_equipment_slot(slot_name):
	return $Equipment.get_node(slot_name)

func find_equipment_slot(type):
	for slot in $Equipment.get_children():
		if slot.type == type:
			return slot
	return false

func connect_equipment(item):
	item.get_node("Entity").connect("stats_updated", self, "update_stats")
	item.get_node("Entity").connect("buffs_updated", self, "update_buffs")

func disconnect_equipment(item):
	if item.get_node("Entity").is_connected("stats_updated", self, "update_stats"):
		item.get_node("Entity").disconnect("stats_updated", self, "update_stats")
	if item.get_node("Entity").is_connected("buffs_updated", self, "update_buffs"):
		item.get_node("Entity").disconnect("buffs_updated", self, "update_buffs")

func _on_equipment_ready():
	update_equipment()
	for item in equipment:
		emit_signal("item_equipped",item)
		connect_equipment(item)
		item.item_owner = self

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
	return status
#	add_child(status)

func add_status_from_buff(buff):
	var status_existing = find_status_from_buff(buff)
	if status_existing:
		status_existing.properties = buff.properties.duplicate()
		return status_existing
	else:
		return add_status(buff.new_status(self))

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

func _on_status_expired(status):
	remove_status(status)

func find_status_from_buff(buff):
	for status in status_current:
		if status.buff == buff:
			return status
	return false

func _on_buffs_ready():
	for buff in $Buffs.get_children():
		add_buff_base(buff)

###################
#    ATTACKS
###################

func create_attack():
	var atk = stats.duplicate()
	atk.faction = faction
	atk.creator = self
	atk.buffs = buffs
	return atk

func receive_attack(atk):
	if not faction == atk.faction:
		
		# Activate statuses from buffs
		if atk.has("buffs"):
			for buff in atk.buffs:
				var s = add_status_from_buff(buff)
				s.properties.faction = atk.faction
		
		# Take damage
		if atk.has("damage"):
			modify_health(-atk.damage)
			var counter = dmg_counter.instance()
			counter.get_node("Damage Counter").text = String(floor(atk.damage))
			Global.entities.add_child(counter)
			counter.global_position = global_position
		
		emit_signal("attack_received", atk)
		return true
		
	else:
		return false

###################
#    STATE
###################
