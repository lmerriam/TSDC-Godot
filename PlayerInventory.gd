extends Control

var player
var selected_item

func _ready():
	player = Global.player
	player.set_list_control($ItemList)

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
	if player.accepts_type(item.type):
		$ItemSelected/EquipButton.visible = true
	else:
		$ItemSelected/EquipButton.visible = false

func _on_EquipButton_button_up():
	# Get previous item
	var item_type = selected_item.get_type()
	var prev_item = player.get_equipped(item_type)
	
	# Remove previous item from equipment and send to inv
	player.remove_equipped(prev_item)
	player.add_item(prev_item)
	
	# Remove selected item from inventory and equip
	player.remove_item(selected_item)
	player.set_equipped(selected_item)
	
	# Reset the selected item
	_set_selected_item(null)

func _on_filter_button_up(type):
	$ItemList.filter = type
	$ItemList.update_list()