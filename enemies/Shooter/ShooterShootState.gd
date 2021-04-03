extends State

export var proj_path = preload("res://attacks/Projectile.tscn")
export var duration := 0.5

func update(delta):
	var atk = owner.get_node("Entity").create_attack()
	var projectile = proj_path.instance() as Projectile
	Global.entities.add_child(projectile)
	projectile.set_attack_properties(atk)
	projectile.global_position = owner.global_position
	projectile.set_angle(projectile.global_position.direction_to(owner.target.global_position))
	projectile.speed = 6
	
	owner.attack_timer = 1
	
	transition_to( "Cooldown")
