extends State

var current_charge
export(Texture) var charging_sprite
export(NodePath) var line

func _ready():
	line = get_node(line)

func enter():
	current_charge = 0
	entity.get_node("Sprite").texture = charging_sprite
	line.visible = true
	line.scale.x = 0


func update(delta):
	if entity.is_attacking == false:
		var atk = entity.item_owner.create_attack()
		var angle = entity._get_vector_to_mouse()
		var area = entity._create_attack_area(atk, Global.entities, angle, entity.global_position)
		atk.damage *= current_charge_level()
		area.speed *= current_charge_level()
		line.visible = false
		emit_signal("finished","cooldown")
		
	current_charge += delta
	var rot = entity.global_position.angle_to_point(entity.get_global_mouse_position())
	entity.get_node("Sprite").rotation = rot + .75
	line.scale.x = current_charge_level()
#	line.rotation = rot


func exit():
	entity.start_cooldown()


func current_charge_level():
	var pct = clamp(current_charge / entity.charge_time + .5, 0, 1)
	return pct