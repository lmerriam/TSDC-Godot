extends State
class_name StateMachine

signal state_changed(current_state)

export(NodePath) var START_STATE
export var root_machine := false
var states_map = {}

var states_stack = []
var current_state = null
var _active = false setget set_active


func _ready():
	
	for child in get_children():
		states_map[child.name] = child
	
	print(states_map)
	
	initialize(START_STATE)
	if root_machine:
		set_active(true)
	else:
		set_active(false)


func initialize(start_state):
	states_stack.push_front(get_node(start_state))
	current_state = states_stack[0]
	current_state.enter()


func set_active(value):
	_active = value
	set_physics_process(value)
	set_process_input(value)
	if not _active:
		states_stack = []
		current_state = null


func _input(event):
	current_state.handle_input(event)


func _physics_process(delta):
	current_state.update(delta)


func _on_animation_finished(anim_name):
	if not _active:
		return
	current_state._on_animation_finished(anim_name)


func _change_state(state_name):
	if not _active:
		return
	current_state.exit()
	
	if state_name == "previous":
		states_stack.pop_front()
	else:
		states_stack[0] = states_map[state_name]
	
	current_state = states_stack[0]
	emit_signal("state_changed", current_state)
	
	if state_name != "previous":
		current_state.enter()


func enter():
	initialize(START_STATE)
	set_active(true)


func exit():
	current_state.exit()
	set_active(false)
