extends ComponentBase
class_name ComponentEquipment

var equipment := {}
var equipment_slots := []
var equipment_stats_cumulative := {}
var type = "ComponentEquipment"

var stats_component

func init(_entity,_siblings):
	.init(_entity,_siblings)
	stats_component = get_sibling(ComponentStats)

func update_stats_with_equipment():
	var stats = stats_component.get_stats_base().duplicate()
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