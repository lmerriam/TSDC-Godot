extends TileMap
#
#export var map_width = 300
#export var map_height = 300
#export var lacunarity = 0
#export var octaves = 4
#export var period = 20.0
#export var persistence = 0.8
#export var grass_threshold = 0.20
#export var water_threshold = 0.00
#
#var noise = _gen_noise()
#var nodes = []
#var node_edges = []
#var time_before
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	generate_map(noise,map_width,map_height)
#	_gen_nodes()
##	_place_player()
#
#	for node in nodes:
#		var stronghold = load("res://Stronghold.tscn").instance()
#		Global.entities.add_child(stronghold)
#		stronghold.global_position = node.origin*cell_size.x
#		node.stronghold = stronghold
##		print(node.level)
##		stronghold.level = node.level * 10
#
#
## Generate base terrain
#func generate_map(noise,width,height):
#	clear()
#
#	time_before = OS.get_ticks_msec()
#	for x in range(width):
#		for y in range(height):
#			var tile
#			var value = noise.get_noise_2d(x,y)
#			if value > grass_threshold:
#				tile = tile_set.find_tile_by_name("Grass")
#			elif value < water_threshold:
#				tile = tile_set.find_tile_by_name("Water")
#
#			if tile != null:
#				set_cell(x,y,tile)
#	var newtime = OS.get_ticks_msec()
#	print("Time to set tiles: " + String(newtime-time_before))
#	time_before = newtime
#
#	update_bitmask_region(Vector2(0,width),Vector2(0,height))
#	get_parent().get_node("Background").rect_size = Vector2(width*cell_size.x,height*cell_size.y)
#
#	newtime = OS.get_ticks_msec()
#	print("Time to bitmask: " + String(newtime-time_before))
#	time_before = newtime
#
#func _on_BtnGenMap_button_up():
#	noise = _gen_noise()
#	generate_map(noise,map_width,map_height)
#	_gen_nodes()
##	_place_player()
#
#func _gen_noise():
#	randomize()
#	var noise = OpenSimplexNoise.new()
#
#	noise.seed = randi()
#	noise.lacunarity = lacunarity
#	noise.octaves = octaves
#	noise.period = period
#	noise.persistence = persistence
#
#	return noise
#
#func _gen_nodes():
#	nodes.clear()
#	for i in 30:
#		var origin = Vector2(rand_range(0,map_width),rand_range(0,map_height))
#		var elevation = noise.get_noise_2dv(origin)
#		if elevation > water_threshold:
#			var node = {}
#			node.origin = origin
#			node.neighbors = []
#			nodes.append(node)
#	_connect_nodes()
#
#func _connect_nodes():
#	var unconnected_nodes = nodes.duplicate()
#	var connected_nodes = []
#
#	# Transfer the first node over as a starting point
#	connected_nodes.append(unconnected_nodes[0])
#	unconnected_nodes.remove(0)
#
#	while unconnected_nodes.size() > 0:
#		var dis_nearest = INF
#		var node_existing
#		var node_new
#		for node_con in connected_nodes:
#			for node_un in unconnected_nodes:
#				var dis = node_con.origin.distance_to(node_un.origin)
#				if dis < dis_nearest:
#					dis_nearest = dis
#					node_existing = node_con
#					node_new = node_un
#		node_new.level = connected_nodes.size()
##		print(node_new)
#		node_existing.neighbors.append(node_new)
#		node_new.neighbors.append(node_existing)
#		connected_nodes.append(node_new)
#		unconnected_nodes.erase(node_new)
#
#func _place_player():
#	var origin = nodes[0].origin
#	Global.player.global_position = origin * cell_size
#
#func _gen_building(width, height):
#	var bsp = []
#	var axes = ["h","v"]
#	var axis = axes[randi() % 2]
#
#	if axis == "h":
#		pass
#	elif axis == "v":
#		pass
#
#func _gen_strongholds():
#	fo
