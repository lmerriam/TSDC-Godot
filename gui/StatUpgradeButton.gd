extends Control

export var stat := "health"

func _ready():
	$StatName.text = stat.capitalize()
	if Global.player_entity.stat_points.has(stat):
		$StatValue.text = String(Global.player_entity.stat_points[stat])

func _on_upgrade_pressed():
	Global.player_entity.spend_stat_points(stat, 1)
	if Global.player_entity.stat_points.has(stat):
		$StatValue.text = String(Global.player_entity.stat_points[stat])
