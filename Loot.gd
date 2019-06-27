extends Area2D
class_name Loot

export var loot_id: String
var loot

func _ready():
	if loot_id:
		set_loot(ItemLibrary.instance_item(loot_id))

func set_loot(instance):
	loot = instance
	$Sprite.set_texture(loot.get_sprite())
	return loot

func get_loot():
	return loot

func _on_Loot_body_entered(body):
	if body == Global.player_character:
		Global.player.add_item(loot)
		queue_free()