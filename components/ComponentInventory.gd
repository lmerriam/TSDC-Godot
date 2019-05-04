extends Node

var slots = []
var control
signal inventory_updated

func _ready():
	control = Global.player.inventory

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
	if "inventory_updated" in control.get_signal_list():
		disconnect("inventory_updated", control, "_on_inventory_updated")
	connect("inventory_updated", new_control, "_on_inventory_updated")
	control = new_control