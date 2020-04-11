extends Weapon

func _process(delta):
	$Sprite.rotation = _get_vector_to_mouse().angle()
	if owner_is_attacking:
		$Sprite/Particles2D.emitting = true
	else:
		$Sprite/Particles2D.emitting = false
#		TODO: Yeah, this is sloppy, shouldn't have to false it every frame
