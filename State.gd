extends Node
class_name State, "res://StateIcon.svg"

signal finished(next_state_name)

export var next_state := "next"

var entity

func _ready():
	entity = owner
	connect("finished", get_parent(), "_change_state")

# Initialize the state. E.g. change the animation
func enter():
	return

# Clean up the state. Reinitialize values like a timer
func exit():
	return

func handle_input(event):
	return

func update(delta):
	return

func _on_animation_finished(anim_name):
	return
