extends CanvasLayer

func _input(event):
	if event.is_action_pressed("ui_inventory"):
		set_current_ui("Inventory")
	elif event.is_action_pressed("ui_cancel"):
		set_current_ui("HUD")
	elif event.is_action_pressed("ui_character"):
		set_current_ui("Character")
	elif event.is_action_pressed("ui_worldmap"):
		set_current_ui("WorldMap")


func set_current_ui(ui_name):
	for child in get_children():
		child.visible = false
	get_node(ui_name).visible = true


func _on_OpenInv_button_up():
	set_current_ui("Inventory")


func _on_OpenChar_button_up():
	set_current_ui("Character")


func _on_HUD_button_up():
	set_current_ui("HUD")


func _on_OpenWorld_button_up():
	set_current_ui("WorldMap")
