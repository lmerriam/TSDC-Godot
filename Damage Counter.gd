extends Label
class_name damage_counter

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
