extends Node

enum {
	SWORD,
	STAFF
}

var equipment = {
	"weapon": {
		"sword": "res://items/weapons/Sword.tscn",
		"staff": "res://items/weapons/Staff.tscn"
	}
}

func _ready():
	pass

func load_item(item_type, item_name):
	return load(equipment[item_type][item_name])