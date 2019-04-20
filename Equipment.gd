extends Node

var equipment = {
	"weapon": {
		"sword": "res://items/weapons/Sword.tscn",
		"staff": "res://items/weapons/Staff.tscn"
	}
}

func _ready():
	var file = File.new()
	file.open("res://items/items.json", file.READ)
	var json = file.get_as_text()
	equipment = JSON.parse(json).result
	file.close()

func load_item(item_type, item_name):
	return load(equipment[item_type][item_name])