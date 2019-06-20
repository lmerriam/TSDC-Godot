extends TileMap


func _ready():
	Global.entities = self
#	generate_props()

func generate_props():
	var noise = OpenSimplexNoise.new()
	var tile = tile_set.find_tile_by_name("flowers_white")
	
	for x in range(200):
		for y in range(200):
			
			if noise.get_noise_2d(x,y) > .3:
				set_cell(x,y,tile)