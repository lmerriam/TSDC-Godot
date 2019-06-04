extends Item

func _init():
	set_type("gem")
	item_name = "Fiery Gem"
	stats_component.set_stat_base("damage", 10)
	
	var fire = Status.Fire.new()
	fire.init(5,5)
	add_buff_base(fire)