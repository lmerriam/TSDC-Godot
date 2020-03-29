extends "res://attacks/Projectile.gd"

var recalling := false
var target_entity

func recall(entity):
	target_entity = entity
	recalling = true
	return true
