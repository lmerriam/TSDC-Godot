extends Control

var item
var selected_mod
var selected_slot
var selected_slot_idx

func _ready():
	$ModList.slots = Global.player_entity.inventory_slots

func set_item(_item):
	item = _item
	$ItemTooltip.set_item(item)
	update_slots()

func update_slots():
	$ItemSlots.clear()
	for slot in item.equipment_slots:
		var equipped_mod = item.get_equipped(slot)
		if equipped_mod:
			var item_name = equipped_mod.get_name()
			var item_sprite = equipped_mod.get_sprite()
			var item_idx = $ItemSlots.get_item_count()
			$ItemSlots.add_item(item_name, item_sprite)
			$ItemSlots.set_item_metadata(item_idx, equipped_mod)
		else:
			var item_idx = $ItemSlots.get_item_count()
			$ItemSlots.add_item(slot + " slot empty", load("res://sprites/icon.png"))
			$ItemSlots.set_item_metadata(item_idx, null)
	if selected_slot_idx:
		$ItemSlots.select(selected_slot_idx)

func _on_equip_button_up():
	$ModTooltip.hide()
	item.set_equipped(selected_mod)
	Global.player.remove_item(selected_mod)
	$ItemTooltip.set_item(item)
	$ModList.hide()
	update_slots()

func _on_remove_button_up():
	$ModTooltip.hide()
	item.remove_equipped(selected_slot)
	Global.player.add_item(selected_slot)
	$ItemTooltip.set_item(item)
	$ModList.show()
	$ModList.update_list()
	update_slots()

func _on_mod_selected(index):
	$ModTooltip.show()
	selected_mod = $ModList.get_item_metadata(index)
	$ModTooltip.set_item(selected_mod)
	$ModTooltip/RemoveButton.hide()
	$ModTooltip/EquipButton.show()

func _on_slot_selected(index):
	$ModList.show()
	selected_slot = $ItemSlots.get_item_metadata(index)
	selected_slot_idx = index
	if selected_slot:
		$ModList.hide()
		$ModList.filter = selected_slot.type
		$ModTooltip.show()
		$ModTooltip.set_item(selected_slot)
		$ModTooltip/RemoveButton.show()
		$ModTooltip/EquipButton.hide()
	else:
		$ModList.show()
		$ModList.filter = item.equipment_slots[selected_slot_idx]
		$ModList.update_list()
		$ModTooltip.hide()
