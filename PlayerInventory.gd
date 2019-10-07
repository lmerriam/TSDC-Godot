extends Control

var player
var selected_item

func _ready():
	player = Global.player_entity
	player.set_list_control($ItemList)

func _set_selected_item(item):
	selected_item = item
	if selected_item:
		$ItemSelected.set_item(item)
		$ItemSelected.show()
		
		if selected_item in player.equipment.values():
			$ItemSelected/EquipButton.hide()
			$ItemSelected/UnequipButton.show()
		else:
			$ItemSelected/EquipButton.show()
			$ItemSelected/UnequipButton.hide()
	else:
		$ItemSelected.hide()

func _on_ItemList_item_selected(index):
	var item = $ItemList.get_item_metadata(index)
	_set_selected_item(item)
	$ItemSelected/UnequipButton.hide()
	if player.accepts_type(item.type):
		$ItemSelected/EquipButton.show()
	else:
		$ItemSelected/EquipButton.hide()

func _on_EquipButton_button_up():
	# Get previous item
	var item_type = selected_item.get_type()
	var prev_item = player.get_equipped(item_type)
	
	# Remove previous item from equipment and send to inv
	if prev_item:
		Global.player.remove_equipped(prev_item)
		player.add_item(prev_item)
	
	# Remove selected item from inventory and equip
	player.remove_item(selected_item)
	Global.player.set_equipped(selected_item)
	
	# Reset the selected item
	_set_selected_item(null)

func _on_filter_button_up(type):
	$ItemList.filter = type
	$ItemList.update_list()

func _on_modify_button_up():
	$ModifyPopup.popup()
	$ModifyPopup/ItemMods.set_item(selected_item)

func _on_CloseModify_button_up():
	$ModifyPopup.hide()
	$ItemSelected.set_item(selected_item)

func _on_equipment_slot_selected(type):
	var item = player.equipment[type]
	_set_selected_item(item)
	$ItemList.

func _on_unequip_button_up():
	Global.player.remove_equipped(selected_item)
	player.add_item(selected_item)
