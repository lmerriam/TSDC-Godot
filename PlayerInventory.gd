extends Control

var inventory
var selected_item
var equipment

func _ready():
	inventory = Global.player
	equipment = Global.player
	Global.player.set_list_control($ItemList)

func _set_selected_item(item):
	selected_item = item
	if selected_item:
		$ItemSelected.set_item(item)
		$ItemSelected.visible = true
	else:
		$ItemSelected.visible = false

func _on_ItemList_item_selected(index):
	var item = $ItemList.get_item_metadata(index)
	_set_selected_item(item)
	if equipment.accepts_type(item.type):
		$ItemSelected/EquipButton.visible = true
	else:
		$ItemSelected/EquipButton.visible = false

func _on_EquipButton_button_up():
	
	# Get previous item
	var item_type = selected_item.get_type()
	var prev_item = equipment.get_equipped(item_type)
	
	# Remove previous item from equipment and send to inv
	equipment.remove_equipped(prev_item)
	inventory.add_item(prev_item)
	
	# Remove selected item from inventory and equip
	inventory.remove_item(selected_item)
	equipment.set_equipped(selected_item)
	
	# Reset the selected item
	_set_selected_item(null)

func _on_filter_button_up(type):
	$ItemList.filter = type
	$ItemList.update_list()