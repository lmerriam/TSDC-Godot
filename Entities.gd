extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.entities = self
#	generate_props()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generate_props():
	var noise = OpenSimplexNoise.new()
	var tile = tile_set.find_tile_by_name("flowers_white")
	
	for x in range(200):
		for y in range(200):
			
			if noise.get_noise_2d(x,y) > .3:
				set_cell(x,y,tile)