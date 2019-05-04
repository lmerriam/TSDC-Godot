extends Area2D

export var loot_id = "sword"
var loot

func _ready():
	set_loot(ItemLibrary.instance_item(loot_id))
	$Sprite.set_texture(loot.get_sprite())

func set_loot(instance):
	loot = instance
	return loot

func get_loot():
	return loot

func _on_Loot_body_entered(body):
	if body == Global.player:
		Global.inventory.add_item(loot)
		queue_free()