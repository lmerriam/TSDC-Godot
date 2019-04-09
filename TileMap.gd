extends TileMap

export var octaves = 4
export var period = 20.0
export var persistence = 0.8
export var grass_threshold = 0.20
export var water_threshold = 0.00
export var map_width = 300
export var map_height = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_map(octaves,period,persistence,grass_threshold,water_threshold)

func _on_BtnGenMap_button_up():
	generate_map(octaves,period,persistence,grass_threshold,water_threshold)

func generate_map(octaves,period,persistence,grass_threshold,water_threshold):
	clear()
	
	var noise = OpenSimplexNoise.new()
	
	noise.seed = randi()
	noise.octaves = octaves
	noise.period = period
	noise.persistence = persistence
	
	for x in range(map_width):
		for y in range(map_height):
			var tile
			var value = noise.get_noise_2d(x,y)
			if value > grass_threshold:
				tile = tile_set.find_tile_by_name("Grass")
			elif value < water_threshold:
				tile = tile_set.find_tile_by_name("Water")
			
			if tile != null:
				set_cell(x,y,tile)
	
	update_bitmask_region(Vector2(0,map_width),Vector2(0,map_width))