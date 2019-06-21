extends Item

func _init():
	set_type("gem")
	item_name = "Fire Gem"
	
	add_buff_base(FireBuff.new({"duration": 5, "damage": 5}))