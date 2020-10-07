extends State

export var anim_name := "windup"

func enter():
	owner.connect("animation_finished", self, "_on_animation_finished")
	owner.play_animation(anim_name)

func update(delta):
	pass

func exit():
	owner.disconnect("animation_finished", self, "_on_animation_finished")

func _on_animation_finished(anim):
	if anim == anim_name:
		emit_signal("finished",next_state)
