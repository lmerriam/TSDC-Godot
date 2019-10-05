extends Control

export var type: String
onready var equipment_slots = Global.player_entity.equipment
var item

signal slot_selected

func _ready():
	if type:
		update_slot()
	Global.player_entity.connect("item_equipped", self, "_on_equipment_updated")
	Global.player_entity.connect("item_unequipped", self, "_on_equipment_updated")

func update_slot():
	if equipment_slots.has(type):
		item = equipment_slots[type]
		$Button/TextureRect.texture = item.get_sprite()
	else:
		$Button/TextureRect.texture = null

func _on_equipment_updated(_item):
	update_slot()

func _on_slot_clicked():
	emit_signal("slot_selected", type)
