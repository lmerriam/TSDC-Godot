extends State

func _process(delta):
	var player_pos = Global.player_character.global_position
	entity.move_toward_point(player_pos)
	if $Enemy.global_position.distance_to(player_pos) < 16:
		var atk = AttackResource.new("enemies", 1)
		Global.player.receive_attack(atk)
		state = STUNNED
		stun_timer = 1