extends Item

func _init():
	type = "gem"
	item_name = "Ice Gem"
	
	add_buff_base(ColdBuff.new({"duration": 4, "amount": .5}))