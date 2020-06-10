extends Node2D

export var map_width = 300
export var map_height = 300
export var lacunarity = 0
export var octaves = 4
export var period = 20.0
export var persistence = 0.8
export var grass_threshold = 0.20
export var water_threshold = 0.00
export var cliff_threshold = 0.30

export var process_chunks := false
export var chunk_size := 13
var current_chunk := Vector2(0,0)
var active_chunks = []
signal chunk_changed(new_chunk, old_chunk)

var noise = _gen_noise()
var nodes = []
var node_edges = []

var path_tiles = []

var time_before

var tiles = {}

# Called when the node enters the scene tree for the first time.
func _ready():
#	_gen_nodes()
	$Background.rect_size = Vector2(map_width*$Environment.cell_size.x,map_height*$Environment.cell_size.y)
#	_place_player()
	for node in nodes:
		var stronghold = load("res://Building.tscn").instance()
		$Entities.add_child(stronghold)
		stronghold.global_position = node.origin*$Environment.cell_size.x
#		node.stronghold = stronghold
#		stronghold.level = node.level * 10
#		Generators.gen_building(node.origin, 13, 13, $Walls, $Walls.tile_set.find_tile_by_name("walls"))
		for x in range(node.origin.x-5,node.origin.x+6):
			for y in range(node.origin.y-5,node.origin.y+6):
				path_tiles.append(Vector2(x,y))
	if process_chunks:
		_on_chunk_changed(_get_current_chunk(),Vector2(0,0))

func _process(delta):
	var chunk = _get_current_chunk()
	if process_chunks and chunk != current_chunk:
		emit_signal("chunk_changed",chunk,current_chunk)
		current_chunk = chunk

func _get_current_chunk():
	return (_get_player_tile_position() / chunk_size).floor()

func _get_player_tile_position():
	return (Global.player.global_position / $Environment.cell_size.x).floor()

func _on_chunk_changed(new_chunk, old_chunk):
	$Environment.clear()
#	time_before = OS.get_ticks_msec()
	var start_x = 0
	var end_x = map_width
	var start_y = 0
	var end_y = map_height
	var grass = $Environment.tile_set.find_tile_by_name("grass")
	var water = $Environment.tile_set.find_tile_by_name("water")
	var cliff = $Environment.tile_set.find_tile_by_name("cliffs")
	var path = $Environment.tile_set.find_tile_by_name("path")
	for x in range(start_x, end_x):
		for y in range(start_y, end_y):
			var tile
			var value = noise.get_noise_2d(x,y)
			
			if path_tiles.has(Vector2(x,y)):
				tile = path
			elif value > cliff_threshold:
				tile = cliff
			elif value > grass_threshold:
				tile = grass
			elif value < water_threshold:
				tile = water

			if tile != null:
				$Environment.set_cell(x,y,tile)
	$Environment.update_bitmask_region(Vector2(start_x,start_y),Vector2(end_x,end_y))

func _on_BtnGenMap_button_up():
	noise = _gen_noise()
	_on_chunk_changed(current_chunk,current_chunk)

func _gen_noise():
	randomize()
	var _noise = OpenSimplexNoise.new()
	_noise.seed = randi()
	_noise.lacunarity = lacunarity
	_noise.octaves = octaves
	_noise.period = period
	_noise.persistence = persistence
	return _noise

func _gen_nodes():
	nodes.clear()
	for i in 30:
		var origin
		var nearest = 0
		while nearest < 100:
			origin = Vector2(rand_range(0,map_width),rand_range(0,map_height))
			var nearest_known = 999
			for n in nodes:
				var dis = n.origin.distance_to(origin)
				if dis < nearest_known:
					nearest_known = dis
			nearest = nearest_known
		
		var node = {}
		node.origin = origin.floor()
		node.neighbors = []
		nodes.append(node)
	_connect_nodes()

func _connect_nodes():
	var unconnected_nodes = nodes.duplicate()
	var connected_nodes = []

	# Transfer the first node over as a starting point
	connected_nodes.append(unconnected_nodes[0])
	unconnected_nodes.remove(0)
	connected_nodes[0].level = 1

	while unconnected_nodes.size() > 0:
		var dis_nearest = INF
		var node_existing
		var node_new
		for node_con in connected_nodes:
			for node_un in unconnected_nodes:
				var dis = node_con.origin.distance_to(node_un.origin)
				if dis < dis_nearest:
					dis_nearest = dis
					node_existing = node_con
					node_new = node_un
		node_existing.neighbors.append(node_new)
		node_new.neighbors.append(node_existing)
		connected_nodes.append(node_new)
		unconnected_nodes.erase(node_new)
		node_new.level = node_existing.level + 1
		
		draw_tile_path(node_existing.origin.x,node_existing.origin.y,node_new.origin.x,node_new.origin.y)

func _place_player():
	var origin = nodes[0].origin
	Global.player.global_position = origin * $Environment.cell_size

func _gen_building(width, height):
	var bsp = []
	var axes = ["h","v"]
	var axis = axes[randi() % 2]

	if axis == "h":
		pass
	elif axis == "v":
		pass

func calculate_point_index(point):
	return point.x + map_width * point.y

func draw_tile_path(x0,y0,x1,y1):
	var xDist = abs(x1 - x0)
	var yDist = -abs(y1 - y0)
	var xStep = 1 if x0 < x1 else -1
	var yStep = 1 if y0 < y1 else -1
	var error = xDist + yDist
	
	$Environment.set_cell(x0, y0, $Environment.tile_set.find_tile_by_name("path"))
	
	while (x0 != x1 or y0 != y1):
		if (2*error - yDist > xDist - 2*error):
			error += yDist
			x0 += xStep
		else:
			error += xDist
			y0 += yStep
		
		$Environment.set_cell(x0, y0, $Environment.tile_set.find_tile_by_name("path"));
		path_tiles.append(Vector2(x0,y0))
	$Environment.update_bitmask_region(Vector2(x0,y1),Vector2(x1,y1))
	
