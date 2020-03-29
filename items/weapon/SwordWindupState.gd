extends State

export var duration := 0.2
export var cancelable := false

export (String) var finished_state
export (String) var canceled_state

var windup_timer

func enter():
	windup_timer = duration

func update(delta):
	windup_timer -= delta
	
	if windup_timer <= 0:
		emit_signal("finished", "Swing")
	elif not owner.is_attacking and cancelable:
		get_parent().emit_signal("finished", "Idling")
