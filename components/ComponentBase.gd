extends Node
class_name ComponentBase

#var component_type = ComponentLibrary.get_type(self)
onready var entity = get_parent()

func get_sibling_component(type):
	if entity.has_node(type):
		return entity.get_node(type)