extends Node

var player
var player_entity
var game
var camera
var inventory
var entities
var gamespeed = 1 setget set_gamespeed
var gamepads = {}
var announcements = []

signal gamespeed_changed(new_value, old_value)
signal announcement_added

func set_gamespeed(value):
	if value >= 0 and value <= 1:
		emit_signal("gamespeed_changed", value, gamespeed)
		gamespeed = value
	else:
		print("Out-of-range gamespeed")

func on_gamepad_changed(padname, force):
	gamepads[padname] = force

func get_gamepad_force(padname):
	return gamepads[padname]

func add_announcement(primary, secondary):
	var an = {"primary": primary, "secondary": secondary}
	announcements.append(an)
	emit_signal("announcement_added")

func get_announcement(index):
	return announcements[index]

func pop_announcement():
	return announcements.pop_front()

#func change_level():
#	get_tree().find_node("Game"). 
