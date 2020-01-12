extends StateMachine

func _ready():
	states_map = {
		"attack": $Attacking,
		"idle": $Idling
	}