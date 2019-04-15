extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
#	generate_map()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generate_map():
	var tiles = ["stump","rock","rock_2"]
	var tile_name = tiles[rand_range(0,2)]
	var tile = tile_set.find_tile_by_name(tile_name)
	for i in 1000:
		var x = rand_range(0,300)
		var y = rand_range(0,300)
		var noise = get_node("/root/Game/World").noise
		if noise.get_noise_2d(x,y) > 0:
			set_cell(x,y,tile)