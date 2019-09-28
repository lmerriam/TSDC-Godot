extends StateMachine

func _ready():
	states_map = {
		"attack": $Attack,
		"idle": $Idle
	}