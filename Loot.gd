extends Area2D
class_name Loot

func set_item(inst):
	$Slot.add_child(inst)

func get_item():
	return $Slot.get_child(0)

func _on_Loot_body_entered(body):
	if body == Global.player and $Slot.get_child_count() > 0:
		var item = get_item()
		Global.player_entity.add_item(item)
		$Slot.remove_child(item)
		queue_free()
