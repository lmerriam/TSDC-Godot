extends Control

func set_text(primary, secondary):
	$VBoxContainer/BigLabel.text = primary
	$VBoxContainer/Label.text = secondary
