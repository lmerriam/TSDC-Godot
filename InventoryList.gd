extends ItemList
class_name InventoryList

var filter
var slots

func add_to_list(item): 
	var item_name = item.get_name()
	var item_sprite = item.get_sprite()
	var item_idx = get_item_count()
	add_item(item_name, item_sprite)
	set_item_metadata(item_idx, item)

func update_list():
	clear()
	for item in slots:
		if filter == null or item.type == filter:
			add_to_list(item)
	

func _on_inventory_updated():
	update_list()