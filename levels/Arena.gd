extends YSort

var current_wave := 1

func _on_wave_completed():
	Global.add_announcement("Wave " + String(current_wave) +  " Complete", "")
	current_wave += 1
