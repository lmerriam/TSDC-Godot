extends Control

export var slot: String
onready var player = Global.player_entity
var item

signal slot_selected

func _ready():
	if slot:
		update_slot()
	Global.player_entity.connect("item_equipped", self, "_on_equipment_updated")
	Global.player_entity.connect("item_unequipped", self, "_on_equipment_updated")

func update_slot():
	if player.get_equipped(slot):
		$Label.text = name
		item = player.get_equipped(slot)
		$Button/TextureRect.texture = item.get_sprite()
	else:
		$Button/TextureRect.texture = null

func _on_equipment_updated(_item):
	update_slot()

func _on_slot_clicked():
	emit_signal("slot_selected", slot)
