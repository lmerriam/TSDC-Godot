extends Particles2D

var time_left

func _init():
	time_left = lifetime
	one_shot = true

func _process(delta):
	time_left -= delta
	if time_left <= 0:
		queue_free()