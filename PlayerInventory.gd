extends Control

var inventory
var selected_item

func _ready():
	inventory = Global.inventory
	inventory.set_control(self)

func add_item(item): 
	var item_name = item.get_name()
	var item_sprite = item.get_sprite()
	var item_idx = $ItemList.get_item_count()
	$ItemList.add_item(item_name, item_sprite)
	$ItemList.set_item_metadata(item_idx, item)
	return item

func update_selected_item(item):
	selected_item = item
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

func _on_inventory_updated(slots):
	$ItemList.clear()
	for item in slots:
		add_item(item)

func _on_ItemList_item_selected(index):
	var item = $ItemList.get_item_metadata(index)
	update_selected_item(item)

func _on_EquipButton_button_up():
	var type = selected_item.get_type()
	var prev_item = Global.player.get_equipped(type)
	
	inventory.add_item(prev_item)
	inventory.remove_item(selected_item)
	Global.player.set_equipped(selected_item)
