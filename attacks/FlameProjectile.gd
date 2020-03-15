extends "res://attacks/Projectile.gd"

func _ready():
	$Sprite.scale.x = .075
	$Sprite.scale.y = .075

func _physics_process(delta):
	$Sprite.scale.x += .005
	$Sprite.scale.y += .005
	
