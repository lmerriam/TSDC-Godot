extends StateMachine

func _ready():
	owner = get_parent()
	assign_owner_to_children(self)

func _change_state(state_name):
	._change_state(state_name)
	$".."/StateLabel.text = state_name

func assign_owner_to_children(node):
	for child in node.get_children():
		child.owner = owner
		if child.get_child_count():
			assign_owner_to_children(child)
