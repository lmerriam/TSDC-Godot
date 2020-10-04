extends State

export var anim_name := "windup"

func start():
	owner.connect("animation_finished", self, "_on_animation_finished")

func update(delta):
	pass

func end():
	owner.disconnect("animation_finished", self, "_on_animation_finished")

func _on_animation_finished(anim):
	if anim == anim_name:
		emit_signal("finished",next_state)
