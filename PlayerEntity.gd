extends Entity

func _init():
	Global.player_entity = self
	set_equipment_slots(["weapon", "armor", "footwear", "amulet"])