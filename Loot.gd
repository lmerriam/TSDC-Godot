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
		Global.entities.add_child(item)
		
		var part = $CPUParticles2D
		remove_child($CPUParticles2D)
		Global.entities.add_child(part)
		part.global_position = global_position
		part.emitting = true
		queue_free()
