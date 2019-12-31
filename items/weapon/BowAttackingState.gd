extends State

export(Texture) var idle_sprite

func enter():
	print("Enter bow cooldown state")
	entity.get_node("Sprite").texture = idle_sprite
#	entity.get_node("Sprite").rotation = 0

func update(delta):
	if entity.is_attacking and !entity.on_cooldown():
		emit_signal("finished","charge")
	
	if entity.is_attacking == false:
		get_parent().emit_signal("finished","idle")