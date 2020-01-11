extends Gem

func _ready():
	$Entity.add_buff_base(CombustBuff.new({"damage": 10, "duration": 5}))