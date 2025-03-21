extends Panel

func _ready():
	pass

func set_item(item):
		var name_label = $Name
		var stats_label = $Stats
		var sprite_rect = $Sprite
		var stats = item.get_node("Entity").stats
		var buffs_base = item.get_node("Entity").buffs_base
		var sprite = item.get_sprite()
		var child_equipment = item.get_node("Entity").equipment
		name_label.clear()
		stats_label.clear()
		sprite_rect.set_texture(sprite)
		
	#		Show item's stats
		name_label.add_text(item.get_name())
		_append_item_info(stats_label,item)
		stats_label.newline()
		
		# Show stats of child items
		for child_item in child_equipment:
#			var child_item = child_equipment[i]
			stats_label.add_text('---')
			stats_label.newline()
			stats_label.add_text(child_item.item_name)
			stats_label.newline()
			_append_item_info(stats_label,child_item)

func _append_item_info(label,item):
	var level = item.get_node("Entity").level
	var stats = item.get_node("Entity").get_stats()
	var buffs_base = item.get_node("Entity").get_buffs_base()
	# Level
	label.add_text("Level " + String(level))
	label.newline()
	#Stats
	for line in stats:
		label.add_text(line + ": " + String(stats[line]))
		label.newline()
	label.newline()
	#Buffs
	for b in buffs_base:
		label.add_text(b.description)
		label.newline()
