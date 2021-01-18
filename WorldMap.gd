extends Control

signal level_selected(level_name)

var world = []
export(TileSet) var tiles

func _ready():
	tiles = $Fog.tile_set
	var startX = randi() % 20 + 1
	var startY = randi() % 20 + 1
	for x in 31:
		world.append([])
		for y in 20:
			var activity = load("res://activities/Encounter.gd").new()
			world[x].append(activity)
			activity.x = x
			activity.y = y
			if (x >= startX - 1 and x <= startX + 1) and (y >= startY - 1 and y <= startY + 1):
				activity.revealed = true
			_update_tile(x,y)


func _update_tile(x, y):
	var activity = world[x][y]
	if activity.revealed:
		$Fog.set_cell(x,y,tiles.find_tile_by_name(activity.map_icon))
	else:
		$Fog.set_cell(x,y,tiles.find_tile_by_name("fog"))


func _on_level_selected(level_name):
	emit_signal("level_selected", level_name)

func _input(event):
	if visible and event is InputEventMouseButton and event.pressed:
		var pos = event.position
		var tile_pos = ($Fog.world_to_map(pos) / 2).floor()
		var activity = world[tile_pos.x][tile_pos.y]
		match activity.map_icon:
			"encounter": 
				emit_signal("level_selected", activity.stage)
