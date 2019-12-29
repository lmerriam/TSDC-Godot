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
#	item.get_node("Entity").update_equipment()
	for slot in item.get_node("Entity").equipment_slots:
		var equipped_mod = item.get_node("Entity").get_equipped(slot)
		if equipped_mod:
			var item_name = equipped_mod.item_name
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
	item.get_node("Entity").set_equipped(selected_mod, item.get_node("Entity").find_equipment_slot(selected_mod.type).name)
	Global.player_entity.remove_item(selected_mod)
	$ItemTooltip.set_item(item)
	$ModList.hide()
	update_slots()

func _on_remove_button_up():
	$ModTooltip.hide()
	item.get_node("Entity").remove_equipped(selected_slot)
	Global.player_entity.add_item(selected_slot)
	$ItemTooltip.set_item(item)
	$ModList.hide()
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
	$ModList.filter = item.get_node("Entity").get_equipment_slot(item.get_node("Entity").equipment_slots[index]).type
	if selected_slot:
		$ModList.hide()
		$ModTooltip.show()
		$ModTooltip.set_item(selected_slot)
		$ModTooltip/RemoveButton.show()
		$ModTooltip/EquipButton.hide()
	else:
		$ModList.show()
		$ModList.update_list()
		$ModTooltip.hide()
