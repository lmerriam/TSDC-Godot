extends Node2D

func _ready():
	Global.entities = $LevelContainer/Level

func _on_WorldMap_level_selected(stage_name):
	change_stage(stage_name)

func change_stage(stage_name):
	var player_parent = Global.player.get_parent()
	player_parent.remove_child(Global.player)
	
	var new_stage : Node = load("res://levels/" + stage_name + ".tscn").instance()
	for n in $LevelContainer.get_children():
		n.queue_free()
	
	$LevelContainer.add_child(new_stage)
	new_stage.add_child(Global.player)
	Global.entities = new_stage.get_parent()
