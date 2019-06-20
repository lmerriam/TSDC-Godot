extends ComponentBase
class_name ComponentInventory

var slots = []
var control
var type = "ComponentInventory"
signal inventory_updated

func add_item(item):
	slots.append(item)
	emit_signal("inventory_updated", slots)
	return item

func remove_item(item):
	slots.erase(item)
	emit_signal("inventory_updated", slots)
	return item

func get_item(slot):
	return slots[slot]

func set_control(new_control):
	if control and control.is_connected("inventory_updated", control, "_on_inventory_updated"):
		disconnect("inventory_updated", control, "_on_inventory_updated")
	connect("inventory_updated", new_control, "_on_inventory_updated")
	control = new_control