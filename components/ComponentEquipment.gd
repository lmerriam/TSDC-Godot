extends ComponentBase
class_name ComponentEquipment

var equipment := {}
var equipment_slots := []
var equipment_stats_cumulative := {}
var type = "ComponentEquipment"

onready var component_stats = entity.get_stats_component()
#onready var stats = component_stats.get_stats()
#onready var stats_base = component_stats.get_stats_base()

func update_stats_with_equipment():
	var stats = entity.get_stats_component().get_stats_base().duplicate()
	for item in equipment:
		var item_stats = get_equipped(item).get_stats()
		for s in item_stats:
			if stats.has(s):
				stats[s] += item_stats[s]
			else:
				stats[s] = item_stats[s]

func get_equipped(type):
	return equipment[type]

func set_equipped(item):
	var type = item.get_type()
	if is_instance_valid(item) and accepts_type(type):
		equipment[type] = item
		entity.add_child(item)
		update_stats_with_equipment()
		return true
	return false

func remove_equipped(item):
	var type = item.get_type()
	equipment[type] = null
	entity.remove_child(item)

func remove_equipped_type(type):
	var item = get_equipped(type)
	remove_equipped(item)

func set_equipment_slots(slots: Array):
	equipment_slots = slots

func accepts_type(type):
	return true if equipment_slots.has(type) or equipment_slots.empty() else false