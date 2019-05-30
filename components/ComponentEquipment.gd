extends ComponentBase
class_name ComponentEquipment

var equipment = {}
var equipment_stats_cumulative = {}
var type = "ComponentEquipment"

onready var component_stats = get_sibling_component('ComponentStats')
onready var stats = component_stats.get_stats()
onready var stats_base = component_stats.get_stats_base()

func update_stats_with_equipment():
	stats = stats_base.duplicate()
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
	if is_instance_valid(item):
		var type = item.get_type()
		equipment[type] = item
		entity.add_child(item)
		update_stats_with_equipment()
		return true
	return false

func remove_equipped(type):
	var instance: Item = get_equipped(type)
	equipment.erase(type)
	entity.remove_child(instance)