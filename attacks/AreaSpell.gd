extends AttackArea

func _ready():
	
	var buff_props = {}
	buff_props.damage = 4
	buff_props.duration = 4
	$Entity.add_buff_base(FireBuff.new(buff_props))
	
	properties = $Entity.create_attack()
	print("Area ready")
