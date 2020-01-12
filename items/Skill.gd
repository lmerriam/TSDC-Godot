extends Equipment

export var cast_speed := 1
var is_casting = false


func start_cooldown():
	set_cooldown(cast_speed)


func on_cast_started():
	is_casting = true


func on_cast_ended():
	is_casting = false