extends Node

const ITEM_FOLDER = "res://items"
const ITEM_JSON = "res://items/items.json"
const WEAPON_FOLDER = "res://items/weapon"
const WEAPON_JSON = "res://items/weapon/weapons.json"
const ARMOR_FOLDER = "res://items/armor"
const ARMOR_JSON = "res://items/armor/armor.json"

var equipment_types := {}
var equipment := {}

var loot := preload("res://Loot.tscn")

func _init():
	equipment = _load_library(ITEM_JSON)
#	equipment_types["weapon"] = _load_library(WEAPON_JSON)
#	equipment_types["armor"] = _load_library(ARMOR_JSON)

func _load_library(path):
	var file = File.new()
	file.open(path, file.READ)
	var json = file.get_as_text()
	var library = JSON.parse(json).result
	file.close()
	return library

func instance_item(item_name):
	return load_item(item_name).instance()

func load_item(item_name):
	return load(equipment[item_name])

func get_random_item():
	var values = equipment.keys()
	return values[randi() % values.size()]

func instance_random_item():
	var item_name = get_random_item()
	return instance_item(item_name)

func instance_random_loot():
	var itm = instance_random_item()
	var lt = loot.instance()
	Global.entities.call_deferred("add_child", lt)
	lt.set_loot(itm)
	return lt