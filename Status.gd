extends Node

class BaseStatus:
	extends Node
	var duration
	var instance
	
	func _ready():
		set_process(false)
	
	func apply(inst):
		instance = inst
		instance.apply_status(self)
		set_process(true)
	
	func expire():
		queue_free()
		instance.remove_status(self)

class Fire:
	extends BaseStatus
	
	var damage
	var current_tick = 1
	
	func init(dmg, dur):
		damage = dmg
		duration = dur
	
	func _process(delta):
		duration -= delta
		current_tick -= delta
		if duration <= 0:
			expire()
		elif current_tick <= 0:
			instance.take_damage(damage)
			current_tick = 1

class Cold:
	extends BaseStatus
	
	var amount
	
	func init(dur, amt):
		duration = dur
		amount = amt
	
	func _process(delta):
		duration -= delta
		if duration <= 0:
			expire()
	
	func apply(inst):
		.apply(inst)
		if inst.has_method("get_stats_component"):
			inst.stats.add_modifier("speed", self, amount)
	
	func expire():
		.expire()
		if instance.has_method("get_stats_component"):
			instance.stats.remove_modifier("speed", self)