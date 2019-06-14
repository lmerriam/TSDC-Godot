class_name AttackResource

var group
var buffs
var damage
var knockback

func _init(_group, _damage=null, _knockback=null, _buffs=null):
	group = _group
	buffs = _buffs
	damage = _damage
	knockback = _knockback

func transfer_attack(entity):
	if entity.has_method("receive_attack"):
		if entity.receive_attack(self):
			return true
	return false