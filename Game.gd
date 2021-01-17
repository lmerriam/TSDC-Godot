extends Node2D

func _ready():
	Global.entities = $LevelContainer/Level

func _on_WorldMap_level_selected(level_name):
	var player_parent = Global.player.get_parent()
	player_parent.remove_child(Global.player)
	
	var new_level : Node = load("res://levels/" + level_name + ".ldtk").instance()
	for n in $LevelContainer.get_children():
		n.queue_free()
	
	$LevelContainer.add_child(new_level)
	new_level.add_child(Global.player)
	Global.entities = new_level.get_parent()
