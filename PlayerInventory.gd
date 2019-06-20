extends Control

var inventory
var selected_item
var equipment

#func _init():
#	inventory = Global.inventory

func _ready():
	inventory = Global.player
	equipment = Global.player
	Global.player.set_control(self)

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
		var stats = item.stats
		var buffs_base = item.buffs_base
		var sprite = item.get_sprite()
		var child_equipment = item.equipment
		name_label.clear()
		stats_label.clear()
		sprite_rect.set_texture(sprite)
		
#		Show item's stats
		name_label.add_text(item.get_name())
		_append_item_info(stats_label,item)
		stats_label.newline()
		
#		Show stats of child items
		for i in child_equipment:
			var child_item = child_equipment[i]
			stats_label.add_text('---')
			stats_label.newline()
			stats_label.add_text(child_item.item_name)
			stats_label.newline()
			_append_item_info(stats_label,child_equipment[i])
	else:
		$ItemSelected.visible = false

func _on_inventory_updated(slots):
	$ItemList.clear()
	for item in slots:
		add_item(item)

func _on_ItemList_item_selected(index):
	var item = $ItemList.get_item_metadata(index)
	_set_selected_item(item)

func _append_item_info(label,item):
	var stats = item.get_stats()
	var buffs_base = item.get_buffs_base()
	for line in stats:
		label.add_text(line + ": " + String(stats[line]))
		label.newline()
	label.newline()
	for b in buffs_base:
		label.add_text(b.description)
		label.newline()

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