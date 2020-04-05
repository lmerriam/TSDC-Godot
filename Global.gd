extends Node

var player
var player_entity
var inventory
var entities
var gamespeed = 1 setget set_gamespeed
var gamepads = {}

signal gamespeed_changed(new_value, old_value)

func _ready():
	pass

func set_gamespeed(value):
	if value >= 0 and value <= 1:
		emit_signal("gamespeed_changed", value, gamespeed)
		gamespeed = value

func on_gamepad_changed(padname, force):
	gamepads[padname] = force

func get_gamepad_force(padname):
	return gamepads[padname]
