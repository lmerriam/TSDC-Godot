extends Entity
class_name Item

var type
export var item_name := "Base Item"

func get_type():
	return type

func set_type(item_type):
	type = item_type

func get_sprite():
	var sprite = get_node("Sprite")
	return sprite.texture

func get_name():
	return item_name