extends Node

const ITEM_FOLDER = "res://items"
const ITEM_JSON = "res://items/items.json"
var equipment

func _ready():
	var file = File.new()
	file.open(ITEM_JSON, file.READ)
	var json = file.get_as_text()
	equipment = JSON.parse(json).result
	file.close()

func instance_item(item_name):
	return load_item(item_name).instance()

func load_item(item_name):
	return load(equipment[item_name])