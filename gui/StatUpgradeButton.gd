extends Control

export var stat := "health"
export var increment := 1.0

func _ready():
	if Global.player_entity.stat_points.has(stat):
		$StatValue.text = String(Global.player_entity.stat_points[stat])

func _on_upgrade_pressed():
	Global.player_entity.add_stat_point(stat, increment)
	Global.player_entity.update_stats()
	if Global.player_entity.stat_points.has(stat):
		$StatValue.text = String(Global.player_entity.stat_points[stat])
