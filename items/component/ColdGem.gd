extends Gem

func _ready():
	$Entity.add_buff_base(ColdBuff.new({"duration": 3, "amount": .3}))