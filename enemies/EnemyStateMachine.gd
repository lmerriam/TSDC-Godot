extends StateMachine

func _change_state(state_name):
	._change_state(state_name)
	$".."/StateLabel.text = state_name
