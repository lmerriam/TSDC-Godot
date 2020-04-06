extends Control

var selected_item
var selected_slot
onready var player = Global.player_entity

func _ready():
	player.set_list_control($ItemList)

func _set_selected_item(item):
	selected_item = item
	if selected_item:
		$ItemSelected.set_item(item)
		$ItemSelected.show()
		
		if player.equipment.has(selected_item):
			$ItemSelected/EquipButton.hide()
			$ItemSelected/UnequipButton.show()
		else:
			$ItemSelected/EquipButton.show()
			$ItemSelected/UnequipButton.hide()
		
		# Show mod button if moddable
		if item.get_node("Entity").has_equipment:
			$ItemSelected/ModButton.show()
		else:
			$ItemSelected/ModButton.hide()
	else:
		$ItemSelected.hide()

func _on_ItemList_item_selected(index):
	var item = $ItemList.get_item_metadata(index)
	_set_selected_item(item)
	$ItemSelected/UnequipButton.hide()
	
	# Show equip button if equipable
	if player.accepts_type(item.type):
		$ItemSelected/EquipButton.show()
	else:
		$ItemSelected/EquipButton.hide()

func _on_EquipButton_button_up():
	
	# Remove previous item from equipment and send to inv
	var slot = player.find_equipment_slot(selected_item.type).name
	var prev_item = player.get_equipped(slot)
	if prev_item:
		player.add_item(prev_item)
	player.remove_item(selected_item)
	player.set_equipped(selected_item, slot)
	
	# Reset the selected item
	_set_selected_item(null)
#
func _on_filter_button_up(type):
	$ItemList.filter = type
	$ItemList.update_list()

func _on_modify_button_up():
	$ModifyPopup.popup()
	$ModifyPopup/ItemMods.set_item(selected_item)

func _on_CloseModify_button_up():
	$ModifyPopup.hide()
	$ItemSelected.set_item(selected_item)

func _on_equipment_slot_selected(slot):
	selected_slot = slot
	var item = player.get_equipped(slot)
	if item:
		_set_selected_item(item)
		$ItemList.unselect_all()
	else:
		_set_selected_item(null)

func _on_unequip_button_up():
	player.remove_equipped(selected_slot)
	player.add_item(selected_item)


func _on_Inventory_visibility_changed():
	if visible:
		$ItemList.update_list()
