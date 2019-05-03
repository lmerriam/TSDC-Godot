extends Control

var inventory

func _ready():
	inventory = Global.inventory
	inventory.set_control(self)

func add_item(item):
	var item_name = item.get_name()
	var item_idx = $ItemList.get_item_count()
	$ItemList.add_item(item_name)
	$ItemList.set_item_metadata(item_idx, item)
	return item

func update_selected_item(item):
	print("Update selected item")
	var name_label = $ItemSelected/Name 
	var stats_label = $ItemSelected/Stats
	var stats = item.get_stats()
	name_label.clear()
	stats_label.clear()
	name_label.add_text(item.get_name())
	for line in stats:
		stats_label.add_text(line + ": " + String(stats[line]))
		stats_label.newline()

func _on_inventory_updated(slots):
	print("Inventory updated")
	$ItemList.clear()
	for item in slots:
		add_item(item)

func _on_ItemList_item_selected(index):
	var item = $ItemList.get_item_metadata(index)
	update_selected_item(item)