extends Control

func _update_stat_points_count():
	$GridContainer/UnspentStatPoints.label = String(Global.player_entity.unspent_stat_points) + " unspent stat points"
