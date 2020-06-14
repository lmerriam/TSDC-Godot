extends TextureButton

export var level_name : String
signal level_selected(level_name)

func _ready():
	connect("level_selected", owner, "_on_level_selected")

func _on_button_released():
	emit_signal("level_selected", level_name)
