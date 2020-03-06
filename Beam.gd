extends AttackArea

var counter = 0

func set_length(length):
	$Line.set_point_position(1,Vector2(length,0))
	$Line2.set_point_position(1,Vector2(length,0))
	$Particles2D.position.x = length
	$CollisionShape2D.shape.length = length

func set_width(width):
	$Line.width = width
	$Line2.width = width + 2

func _physics_process(delta):
	var length = rand_range(198,202)
	set_length(length)
	set_width(rand_range(2,3.5))
	
	counter += delta
	if counter > .5 and $CollisionShape2D.disabled == false:
		$CollisionShape2D.disabled = true
		counter = 0
	else:
		$CollisionShape2D.disabled = false
