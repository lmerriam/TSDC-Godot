extends Area2D
class_name Attack

var creator
var buffs

func init(_creator, _buffs=null):
	creator = _creator
	buffs = _buffs

func set_creator(group):
	creator = group
	return creator