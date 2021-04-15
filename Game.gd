extends Node2D

var current_stage
var current_activity

func _ready():
	Global.entities = $LevelContainer/Level
	Global.connect("stage_completed", self, "_on_stage_completed")
	Global.connect("activity_selected", self, "_on_activity_selected")

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

func _on_stage_completed():
	$GUI.set_current_ui("World")

func _on_activity_selected(activity):
	current_activity = activity
	if activity.get("stage"):
		change_stage(activity.stage)
		$GUI.set_current_ui("HUD")
