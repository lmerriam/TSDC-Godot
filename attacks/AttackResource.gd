class_name AttackResource

var creator
var buffs
var damage
var knockback

func _init(_creator, _damage, _knockback, _buffs=null):
	creator = _creator
	buffs = _buffs
	damage = _damage
	knockback = _knockback

func transfer_attack(entity):
	if entity.has_method("receive_attack"):
		if entity.receive_attack(self):
			return true
	return false