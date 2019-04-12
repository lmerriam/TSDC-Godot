extends Node2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _draw():
	for node in $World.nodes:
		var cell_size = $World.cell_size
		draw_circle(node.origin*cell_size.x,32,Color.red)