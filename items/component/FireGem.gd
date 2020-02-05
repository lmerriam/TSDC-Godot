extends Gem

func _ready():
	$Entity.add_buff_base(FireBuff.new({"duration":4, "damage":8}))
#	$Entity.set_stat_base("damage", 20)
