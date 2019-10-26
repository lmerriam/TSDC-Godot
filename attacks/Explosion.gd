extends AttackArea

func _ready():
	$AnimatedSprite.play()

func _on_AnimatedSprite_animation_finished():
	queue_free()

func _disable_collision():
	$CollisionShape2D.disabled = true