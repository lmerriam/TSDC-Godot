extends State

var swing_timer

func enter():
	print("Enter swing state...")
	swing_timer = 0.2
	var atk = entity.item_owner.create_attack()
	var angle = entity._get_vector_to_mouse()
	var area = entity._create_attack_area(atk, entity, angle)

func update(delta):
	swing_timer -= delta
	
	if swing_timer <= 0:
		get_parent().emit_signal("finished","idle")

func exit():
	print("Exit swing state")