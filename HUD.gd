extends Control

func _ready():
	Global.player_entity.connect("health_changed", self, "_on_player_health_changed")
	$HealthBar.value = 100

func _on_player_health_changed(_health, _old_health):
	$HealthBar.value = (Global.player_entity.health / Global.player_entity.max_health) * 100
