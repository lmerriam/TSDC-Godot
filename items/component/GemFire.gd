extends Item

func _init():
	set_type("gem")
	item_name = "Fiery Gem"
	
	add_buff_base(FireBuff.new({"duration": 5, "damage": 5}))