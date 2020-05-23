extends Status
class_name FireStatus

var current_tick = 1

func _ready():
	entity.add_child(load("res://particles/FireParticles.tscn").instance())

func _physics_process(delta):
	properties.duration -= delta
	current_tick -= delta
	if properties.duration <= 0:
		expire()
	elif current_tick <= 0:
		
		# Create attack dict
		var atk = {}
		atk.faction = "neutral"
		atk.damage = properties.damage
		
		entity.receive_attack(atk)
		current_tick = 1
