extends StateMachine

#func _ready():
#	states_map = {
#		"chase": $Chase,
#		"attack": $Attack,
#		"wander": $Wander,
#		"stunned": $Stunned
#	}

func _change_state(state_name):
	._change_state(state_name)
	$".."/StateLabel.text = state_name