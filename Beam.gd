extends AttackArea

var counter = 0
export var impact_particles = preload("res://particles/BeamParticles.tscn")

var active_particles = {}

func set_length(length):
	$Line.set_point_position(1,Vector2(length,0))
	$Line2.set_point_position(1,Vector2(length,0))
	$Particles2D.position.x = length + $Line.position.x
	$CollisionShape2D.shape.length = length + $Line.position.x

func set_width(width):
	$Line.width = width
	$Line2.width = width + 2

func _physics_process(delta):
	var length = rand_range(198,202)
	set_length(length)
	set_width(rand_range(2,3.5))
	
	counter += delta
	if counter > .25 and $CollisionShape2D.disabled == false:
		$CollisionShape2D.disabled = true
		counter = 0
	else:
		$CollisionShape2D.disabled = false

func _on_BeamAttack_area_entered(area):
	if not active_particles.has(area):
		var part = impact_particles.instance()
		area.add_child(part)
		part.position = Vector2(0,0)
		active_particles[area] = part


func _on_BeamAttack_area_exited(area):
	if active_particles.has(area):
		area.remove_child(active_particles[area])
		active_particles[area].queue_free()
		active_particles.erase(area)
