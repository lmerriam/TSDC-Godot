extends Area2D
class_name Loot

export var item_path: PackedScene
var item
var item_loaded

func _ready():
	if item_path:
		set_item(item_path.instance())
	if !item.get_parent():
		Global.entities.call_deferred("add_child", item)

func set_item(instance):
	item = instance
	$Sprite.set_texture(item.get_sprite())
#	if item_path:
#		var bundle = item_path._bundled
#		var sprite_idx
#		for i in range(bundle["names"].length):
#			if idx == "Sprite":
#				sprite_idx = idx
#				break
#		var tex = bundle["variants"][sprite_idx]
#		$Sprite.set_texture(tex)
	return item

func get_item():
	return item

func _on_Loot_body_entered(body):
	if body == Global.player_character:
		Global.player.add_item(item)
		queue_free()