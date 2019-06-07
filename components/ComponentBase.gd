class_name ComponentBase extends Reference

var entity: Node
var sibling_components: Dictionary

func init(_entity,_siblings):
	entity = _entity
	sibling_components = _siblings

func get_sibling(type):
	if sibling_components.has(type):
		return sibling_components[type]