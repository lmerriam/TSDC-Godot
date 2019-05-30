extends Node

enum {EQUIPMENT, INVENTORY, STATS}

var components = {
	EQUIPMENT: 'res://components/ComponentEquipment.gd',
	INVENTORY: 'res://components/ComponentInventory.gd',
	STATS: 'res://components/ComponentStats.gd'
}

func _ready():
	pass

func init_component(component):
	if components.has(component):
		return load(components.component).new()

func get_type(id):
	return id.type
#	for comp in components:
#		print(id)
#		print(components[comp])
#		if id is components[comp]:
#			return comp