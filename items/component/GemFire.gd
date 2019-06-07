extends Item

func _init():
	set_type("gem")
	item_name = "Fiery Gem"
	stats_component.set_stat_base("damage", 10)
	
	var buff = Buff.new(FireStatus, {"duration": 5, "damage": 5})
	add_buff_base(buff)