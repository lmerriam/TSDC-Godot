extends AttackArea

var active_timer = .1

func _ready():
	$AnimatedSprite.play()

func _process(delta):
	active_timer -= delta
	if active_timer <= 0:
		$CollisionShape2D.disabled = true

func _on_AnimatedSprite_animation_finished():
	queue_free()