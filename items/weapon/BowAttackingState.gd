extends State

export(Texture) var idle_sprite

func enter():
#	print("Enter bow cooldown state")
	entity.get_node("Sprite").texture = idle_sprite

func update(delta):
	if entity.owner_is_attacking and !entity.on_cooldown():
		get_parent()._change_state("Charging")
	
	if entity.owner_is_attacking == false:
		get_parent().get_parent()._change_state("Idling")
