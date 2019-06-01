extends Control

var inventory
var selected_item
var equipment

#func _init():
#	inventory = Global.inventory

func _ready():
	inventory = Global.inventory
	equipment = Global.player.get_equipment_component()
	inventory.set_control(self)

func add_item(item): 
	var item_name = item.get_name()
	var item_sprite = item.get_sprite()
	var item_idx = $ItemList.get_item_count()
	$ItemList.add_item(item_name, item_sprite)
	$ItemList.set_item_metadata(item_idx, item)
	return item

func _set_selected_item(item):
	selected_item = item
	if item:
		$ItemSelected.visible = true
		var name_label = $ItemSelected/Name 
		var stats_label = $ItemSelected/Stats
		var sprite_rect = $ItemSelected/Sprite
		var stats = item.get_stats()
		var sprite = item.get_sprite()
		name_label.clear()
		stats_label.clear()
		sprite_rect.set_texture(sprite)
		name_label.add_text(item.get_name())
		for line in stats:
			stats_label.add_text(line + ": " + String(stats[line]))
			stats_label.newline()
	else:
		$ItemSelected.visible = false

func _on_inventory_updated(slots):
	$ItemList.clear()
	for item in slots:
		add_item(item)

func _on_ItemList_item_selected(index):
	var item = $ItemList.get_item_metadata(index)
	_set_selected_item(item)

func _on_EquipButton_button_up():
	if selected_item:
		
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