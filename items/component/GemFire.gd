extends Item

func _init():
	set_type("gem")
	stats_component.set_stat_base("damage", 20)