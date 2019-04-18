extends Node2D

var weapon_current = preload("res://items/weapons/staff.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var weapon = weapon_current.instance()
	add_child(weapon)

func set_weapon(weapon_name):
	var weapon_current = load("res://items/weapons/" + weapon_name + ".tscn")