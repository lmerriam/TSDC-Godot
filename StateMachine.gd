extends State
class_name StateMachine

signal state_changed(current_state)

export var root_machine := false
export var debugging := false

var states_map = {}
onready var states_list = get_children()

var states_stack = []
var current_state = null
var _active = false setget set_active


func _ready():
	
	for child in get_children():
		states_map[child.name] = child
		child.owner = owner
	
	if root_machine:
		initialize(get_child(0).name)
		set_active(true)
	else:
		set_active(false)


func initialize(state):
	states_stack.push_front(get_node(state))
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


func _change_state(state_name, args={}):
	if not _active:
		return
	current_state.exit()
	
	if state_name == "next":
		var idx = states_list.find(current_state) + 1
		if idx < states_list.size():
			state_name = states_list[idx].name
		else:
			state_name = states_list[0].name
	
	if state_name == "previous":
		states_stack.pop_front()
	else:
		states_stack[0] = states_map[state_name]
	
	current_state = states_stack[0]
	emit_signal("state_changed", current_state)
	if debugging:
		print("Change state to: " + state_name)
	
	if state_name != "previous":
		current_state.enter()


func enter():
	initialize(get_child(0).name)
	set_active(true)


func exit():
	current_state.exit()
	set_active(false)
