extends Particles2D

#var time_left
#TODO: clean this scene up, remove the particles if we aren't using them
func _ready():
	$AnimatedSprite.play()
#	time_left = lifetime
#	one_shot = true
#	$AnimatedSprite
#
#func _process(delta):
#	time_left -= delta
#	if time_left <= 0:
#		queue_free()

func _on_AnimatedSprite_animation_finished():
	queue_free()
