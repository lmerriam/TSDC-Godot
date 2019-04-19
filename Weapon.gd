extends Position2D

var weapon_start = Global.weapons.staff

var components = {
	base: weapon_start,
	gem: null,
	mat: null
}

func _ready():
	set_weapon(weapon_start)

func set_weapon(path):
	
	var new_weapon = load(path)
	var prev_weapon = weapon_equipped
	if new_weapon:
		
		if prev_weapon:
			remove_child(prev_weapon)
			prev_weapon.queue_free()
		
		weapon_equipped = add_child(new_weapon)
		return weapon_equipped

func set_gem(gem_name):
	pass

func set_material(material_name):
	pass