extends Control

signal level_selected(level_name)

export(TileSet) var tiles

func _ready():
	tiles = $Fog.tile_set
	for x in Overworld.width:
		for y in Overworld.height:
			_update_tile(x,y)

func _update_tile(x, y):
	var activity = Overworld.activities[x][y]
	if activity.revealed:
		$Fog.set_cell(x,y,tiles.find_tile_by_name(activity.map_icon))
	else:
		$Fog.set_cell(x,y,tiles.find_tile_by_name("fog"))


func _on_level_selected(level_name):
	emit_signal("level_selected", level_name)

func _input(event):
	var world = Overworld.activities
	if visible and event is InputEventMouseButton and event.pressed:
		var pos = event.position
		var tile_pos = ($Fog.world_to_map(pos) / 2).floor()
		var activity : Activity = world[tile_pos.x][tile_pos.y]
		if activity.revealed:
			Global.emit_signal("activity_selected", activity)
