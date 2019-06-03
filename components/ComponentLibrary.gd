extends Node

static func init_components(entity: Node, components: Array):
	var new_components = {}
	
	# Instantiate the components and save to list
	for comp in components:
		new_components[comp] = comp.new()
	
	# Call custom init function for each component (allows them to find each other and hook in, etc)
	for comp in new_components:
		var component: ComponentBase = new_components[comp]
#		component.sibling_components = new_components
		component.init(entity,new_components)
	
	return new_components


func get_type(id):
	return id.type
#	for comp in components:
#		print(id)
#		print(components[comp])
#		if id is components[comp]:
#			return comp