extends Item
class_name Armor

var attack_area: Resource
var cooldown := 0.0
var player_speed_modifier := .5

func _init():
	set_type("armor")