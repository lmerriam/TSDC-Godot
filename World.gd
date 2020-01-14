extends Node2D

export var map_width = 300
export var map_height = 300
export var lacunarity = 0
export var octaves = 4
export var period = 20.0
export var persistence = 0.8
export var grass_threshold = 0.20
export var water_threshold = 0.00

export var chunk_size := 13
var current_chunk := Vector2(0,0)
var active_chunks = []
signal chunk_changed(new_chunk, old_chunk)

var noise = _gen_noise()
var nodes = []
var node_edges = []
var time_before

# Called when the node enters the scene tree for the first time.
func _ready():
#	generate_map(noise,map_width,map_height)
	_gen_nodes()
	$Environment/Background.rect_size = Vector2(map_width*$Environment.cell_size.x,map_height*$Environment.cell_size.y)
#	_place_player()
	_on_chunk_changed(_get_current_chunk(),Vector2(0,0))
	for node in nodes:
		var stronghold = load("res://Stronghold.tscn").instance()
		Global.entities.add_child(stronghold)
		stronghold.global_position = node.origin*$Environment.cell_size.x
		node.stronghold = stronghold
		stronghold.level = node.level * 10

func _process(delta):
	var chunk = _get_current_chunk()
	if chunk != current_chunk:
		emit_signal("chunk_changed",chunk,current_chunk)
		current_chunk = chunk

func _get_current_chunk():
	return (_get_player_tile_position() / chunk_size).floor()

func _get_player_tile_position():
	return (Global.player.global_position / $Environment.cell_size.x).floor()

func _on_chunk_changed(new_chunk, old_chunk):
#	for entity in Global.entities.get_children():
#		if ((entity.global_position/$Environment.cell_size.x).floor() / chunk_size).floor() == new_chunk:
#			entity.set_process(true)
#			entity.visible = true
#		else:
#			entity.set_process(false)
#			entity.visible = false
#	Global.player.set_process(true)

	$Environment.clear()
#	time_before = OS.get_ticks_msec()
	var start_x = new_chunk.x * chunk_size - chunk_size
	var end_x = start_x + chunk_size * 3
	var start_y = new_chunk.y * chunk_size - chunk_size*.75
	var end_y = start_y + chunk_size * 2.5
	var grass = $Environment.tile_set.find_tile_by_name("Grass")
	var water = $Environment.tile_set.find_tile_by_name("Water")
	for x in range(start_x, end_x):
		for y in range(start_y, end_y):
			var tile
			var value = noise.get_noise_2d(x,y)
			if value > grass_threshold:
				tile = grass
			elif value < water_threshold:
				tile = water

			if tile != null:
				$Environment.set_cell(x,y,tile)
	$Environment.update_bitmask_region(Vector2(start_x,start_y),Vector2(end_x,end_y))
	
#	var newtime = OS.get_ticks_msec()
#	print("Time to set and bitmask tiles: " + String(newtime-time_before))

func set_tile_region(start,end):
	var start_x = start.x
	var end_x = end.x
	var start_y = start.y
	var end_y = end.y
	var grass = $Environment.tile_set.find_tile_by_name("Grass")
	var water = $Environment.tile_set.find_tile_by_name("Water")
	for x in range(start_x, end_x):
		for y in range(start_y, end_y):
			var tile
			var value = noise.get_noise_2d(x,y)
			if value > grass_threshold:
				tile = grass
			elif value < water_threshold:
				tile = water
	$Environment.update_bitmask_region(Vector2(start_x,start_y),Vector2(end_x,end_y))

#func _draw():
#	for node in nodes:
#		var cell_size = $Environment.cell_size
#		draw_circle(node.origin*cell_size.x,32,Color.red)
#		for neighbor in node.neighbors:
#			draw_line(node.origin*cell_size,neighbor.origin*cell_size,Color.red)

# Generate base terrain
func generate_map(noise,width,height):
	$Environment.clear()

	time_before = OS.get_ticks_msec()
	for x in range(width):
		for y in range(height):
			var tile
			var value = noise.get_noise_2d(x,y)
			if value > grass_threshold:
				tile = $Environment.tile_set.find_tile_by_name("Grass")
			if value < water_threshold:
				tile = $Environment.tile_set.find_tile_by_name("Water")

			if tile != null:
				$Environment.set_cell(x,y,tile)
	var newtime = OS.get_ticks_msec()
	print("Time to set tiles: " + String(newtime-time_before))
	time_before = newtime

	$Environment.update_bitmask_region(Vector2(0,width),Vector2(0,height))

	newtime = OS.get_ticks_msec()
	print("Time to bitmask: " + String(newtime-time_before))
	time_before = newtime

func _on_BtnGenMap_button_up():
	noise = _gen_noise()
	_on_chunk_changed(current_chunk,current_chunk)
#	generate_map(noise,map_width,map_height)
#	_gen_nodes()
#	_place_player()

func _gen_noise():
	randomize()
	var noise = OpenSimplexNoise.new()

	noise.seed = randi()
	noise.lacunarity = lacunarity
	noise.octaves = octaves
	noise.period = period
	noise.persistence = persistence

	return noise

func _gen_nodes():
	nodes.clear()
	for i in 30:
		var origin = Vector2(rand_range(0,map_width),rand_range(0,map_height))
		var elevation = noise.get_noise_2dv(origin)
		if elevation > water_threshold:
			var node = {}
			node.origin = origin
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
#		print("Node new: " + String(node_new.level) + " - Node Existing: " + String(node_existing.level))

#func _level_nodes():
#	var node = nodes[0]
#	var node_levels = {}
	

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