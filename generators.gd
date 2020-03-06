extends Node

func _ready():
	pass

func gen_building(origin, width, height, tilemap, tile):
	var offset = Vector2(width / 2, height / 2)
	var x1 = origin.x - offset.x
	var y1 = origin.y - offset.y
	var x2 = x1 + width - 1
	var y2 = y1 + height - 1
	
	for i in width:
		var x = origin.x - offset.x + i
		tilemap.set_cell(x, y1, tile)
		tilemap.set_cell(x, y2, tile)
	
	for i in height:
		var y = origin.y - offset.y + i
		tilemap.set_cell(x1, y, tile)
		tilemap.set_cell(x2, y, tile)
	
	var door_x = rand_range(1,width-1)
	tilemap.set_cell(x1 + door_x, y2, -1)
	
	tilemap.update_bitmask_region(Vector2(x1,y1),Vector2(x2,y2))
