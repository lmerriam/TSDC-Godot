extends Item
class_name Equipment

var cooldown := 0.0

func _process(delta):
	cooldown -= delta


func set_cooldown(uses_per_sec):
	cooldown = 1.0 / uses_per_sec


func on_cooldown():
	return true if cooldown >= 0 else false


func _get_vector_to_mouse():
	var mouse_pos = get_global_mouse_position()
	var vec = (mouse_pos - global_position).normalized()
	return vec