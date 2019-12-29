extends Equipment
class_name Armor

export var defense := 0
export var speed := 0

func _init():
	$Entity.set_stat_base("defense", defense)
	$Entity.set_stat_base("speed", speed)