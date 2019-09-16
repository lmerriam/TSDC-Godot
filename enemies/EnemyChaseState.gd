extends State

func _process(delta):
	entity.move_toward_point(Global.player_character.global_position)
	if $Enemy.global_position.distance_to(player_pos) < 16:
		var atk = AttackResource.new("enemies", 1)
		Global.player.receive_attack(atk)
		state = STUNNED
		stun_timer = 1