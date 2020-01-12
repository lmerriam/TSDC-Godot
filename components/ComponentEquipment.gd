extends ComponentBase
class_name ComponentEquipment

var equipment := {}
var equipment_slots := []
var equipment_stats := {}
var type = "ComponentEquipment"

var equipment_buffs := []

signal item_equipped
signal item_unequipped
signal item_stats_updated

var stats_component

func init(_entity,_siblings):
	.init(_entity,_siblings)
	stats_component = get_sibling(ComponentStats)

func get_equipment():
	return equipment

func update_equipment_stats():
	equipment_stats.clear()
	equipment_buffs.clear()
	for item_type in equipment:
		var item = get_equipped(item_type)
		var item_stats = item.get_stats_component().get_stats()
		for s in item_stats:
			if equipment_stats.has(s):
				equipment_stats[s] += item_stats[s]
			else:
				equipment_stats[s] = item_stats[s]
			equipment_buffs += item.buffs
	emit_signal("item_stats_updated", equipment_stats)
	return equipment_stats

func get_equipment_stats():
	return equipment_stats

func get_equipped(type):
	return equipment[type]

func set_equipped(item):
	var type = item.get_type()
	if is_instance_valid(item) and accepts_type(type):
		equipment[type] = item
		entity.get_stats_component().update_stats()
		
		# Reparent thi bih
		if not item.get_parent():
			entity.add_child(item)
		
		item.get_equipment_component().connect("item_stats_updated", self, "_on_item_stats_updated")
		emit_signal("item_equipped", item)
		
		return true
	return false

func remove_equipped(item):
	var type = item.get_type()
	equipment[type] = null
	entity.remove_child(item)
	Global.entities.add_child(item)
	
	# Hook up signals
	emit_signal("item_unequipped", item)
	if "item_stats_updated" in item.get_signal_list():
		item.disconnect("item_stats_updated", self, "_on_item_stats_updated")

func remove_equipped_type(type):
	var item = get_equipped(type)
	remove_equipped(item)

func set_equipment_slots(slots: Array):
	equipment_slots = slots

func accepts_type(type):
	return true if equipment_slots.has(type) or equipment_slots.empty() else false

func _on_item_stats_updated():
#	update_equipment_stats()
	entity.get_stats_component().update_stats()