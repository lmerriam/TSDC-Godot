extends Item

func _init():
	set_type("base")
	item_name = "Fast Trigger"

	stats_component.set_stat_base("attack_speed", .4)