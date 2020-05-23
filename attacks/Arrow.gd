extends "res://attacks/Projectile.gd"

var grounded_texture = load("res://sprites/pixeltier/bows/arrow_1_grounded.png")

func _physics_process(delta):
	if time_left <= 0 or speed <= min_speed:
		var sprite = Sprite.new()
		Global.entities.add_child(sprite)
		sprite.global_position = global_position
		sprite.global_rotation = $Sprite.global_rotation
		sprite.texture = grounded_texture
