extends Control

func _on_player_stats_updated():
	$StatList.clear()
	$StatList.create_item().set_text(0,"STATS")
	var stats = Global.player_entity.stats
	for stat in stats:
		var txt = stat + " " + String(stats[stat])
		var line = $StatList.create_item()
		line.set_text(0, txt)
		
		if Global.player_entity.stats_base.has(stat):
			txt = "Base: " + String(Global.player_entity.stats_base[stat])
			$StatList.create_item(line).set_text(0,txt)
		
		for item in Global.player_entity.equipment:
			var item_stats = item.get_node("Entity").stats
			if item_stats.has(stat):
				txt = item.item_name + ": " + String(item_stats[stat])
				$StatList.create_item(line).set_text(0,txt)
		
		line.set_collapsed(true)
