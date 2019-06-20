extends Status
class_name FireStatus

var current_tick = 1

func _process(delta):
	properties.duration -= delta
	current_tick -= delta
	if properties.duration <= 0:
		expire()
	elif current_tick <= 0:
		entity.receive_attack(AttackResource.new(group, properties.damage, null, null))
		current_tick = 1

func start():
	add_child(load("res://particles/FireParticles.tscn").instance())